//
//  CasesTableTableViewController.swift
//  FolksamApp
//
//  Created by Johan Torell on 2021-01-28.
//

import UIKit
import Foundation

class CasesTableViewController: UITableViewController {
    private var casesData: [Case] = []
    weak var delegate: CasesTableViewDelegate?

    public func setData(newData: [Case]) {
        casesData = newData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CaseTableViewCell", bundle: Bundle.module), forCellReuseIdentifier: "caseCell")

        // TODO:
        // refresh jumps and disappears, something to do with constraints for containerview+tableview etc
        // "works" if containerview is constrained to superview instead of safe area, but then, theres a gap when large title becomes small title
        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func refresh(_: Any) {
        delegate?.refreshData { [weak self] in
            guard let self = self else { return }
            self.refreshControl?.endRefreshing()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return casesData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "caseCell", for: indexPath) as? CaseTableViewCell else { return UITableViewCell() }

        // Configure the cell...
        cell.titleLabel.text = casesData[indexPath.row].title
        return cell
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CaseDetailsViewController.make(details: casesData[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             // Delete the row from the data source
             tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
     }
     */

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}

protocol CasesTableViewDelegate: CasesViewController {
    func refreshData(completion: @escaping () -> Void)
}
