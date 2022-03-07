//
//  CaseDetailsViewController.swift
//  FolksamApp
//
//  Created by Johan Torell on 2021-01-28.
//

import FolksamCommon
import UIKit

class CaseDetailsViewController: UIViewController {
    @IBOutlet var descTextView: UITextView!

//    private var apiService: CaseServices!
    private var details: Case!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = details.title
        navigationItem.largeTitleDisplayMode = .always
        descTextView.text = details.desc
    }

    static func make(details: Case) -> CaseDetailsViewController {
        let storyboard = UIStoryboard(name: "CaseDetails", bundle: Bundle(for: Self.self))
        let vc = UIStoryboard.instantiateViewController(from: storyboard, ofType: self)
        vc.details = details
//        viewController.apiService = apiService
        return vc
    }
}
