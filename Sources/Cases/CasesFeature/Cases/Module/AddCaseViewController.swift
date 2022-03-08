//
//  AddCaseViewController.swift
//  FolksamApp
//
//  Created by Johan Torell on 2021-01-29.
//

import UIKit
import Foundation

class AddCaseViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descTextView: UITextView!

    private var apiService: CaseServiceProtocol!
    weak var delegate: AddCaseDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    static func make(apiService: CaseServiceProtocol) -> AddCaseViewController {
        let storyboard = UIStoryboard(name: "AddCase", bundle: Bundle.module)
        let viewController = UIStoryboard.instantiateViewController(from: storyboard, ofType: self)
        viewController.apiService = apiService
        return viewController
    }

    @IBAction func submit(_: Any) {
        apiService.createCase(title: titleTextField.text ?? "", desc: descTextView.text ?? "") { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.addCaseDidFinish()

            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

protocol AddCaseDelegate: UIViewController {
    func addCaseDidFinish()
}
