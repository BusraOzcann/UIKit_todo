//
//  TableViewCell.swift
//  TODO
//
//  Created by Büşra Özcan on 4.10.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
