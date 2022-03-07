//
//  HomeViewController.swift
//  FolksamApp
//
//  Created by Johan Torell on 2021-01-28.
//

import FolksamCommon
import UIKit

public class CasesViewController: UIViewController {
    private var casesData: [Case]!
    private var apiService: CaseServiceProtocol!
    private var tableViewController: CasesTableViewController!

    override public func viewDidLoad() {
        super.viewDidLoad()
        fetchCases(completion: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAddCaseModal))
    }

    public static func make(apiService: CaseServiceProtocol) -> UINavigationController {
        let storyboard = UIStoryboard(name: "CasesTab", bundle: Bundle(for: Self.self))
        let (navigationController, viewController) = UIStoryboard.instantiateNavigationController(
            from: storyboard,
            childOfType: self
        )
        viewController.apiService = apiService
        if #available(iOS 13.0, *) {
            navigationController.tabBarItem = UITabBarItem(title: "Ärenden", image: UIImage(systemName: "message.fill"), selectedImage: UIImage(systemName: "message.fill"))
        } else {
            navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        }

        return navigationController
    }

    override public func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if let tableViewController = segue.destination as? CasesTableViewController {
            self.tableViewController = tableViewController
            tableViewController.delegate = self
        }
    }

    private func fetchCases(completion: (() -> Void)? = nil) {
        apiService.getCases { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .failure(error):
                print(error)
            case let .success(cases):
                self.updateUI(data: cases)
            }
            completion?()
        }
    }

    private func updateUI(data: [Case]) {
        tableViewController.setData(newData: data)
    }

    @objc private func openAddCaseModal() {
        let vc = AddCaseViewController.make(apiService: apiService)
        vc.delegate = self
        navigationController?.present(vc, animated: true, completion: nil)
    }
}

// MARK: - AddCase delegate

extension CasesViewController: AddCaseDelegate {
    func addCaseDidFinish() {
        fetchCases()
    }
}

// MARK: - TableViewDelegate

extension CasesViewController: CasesTableViewDelegate {
    func refreshData(completion: @escaping () -> Void) {
        fetchCases(completion: completion)
    }
}
