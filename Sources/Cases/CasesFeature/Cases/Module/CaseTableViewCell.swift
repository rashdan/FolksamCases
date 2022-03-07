//
//  CaseTableViewCell.swift
//  FolksamApp
//
//  Created by Johan Torell on 2021-01-28.
//

import UIKit

class CaseTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var poirntte: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(title _: String) {
//        titleLabel.text = title
    }
}
