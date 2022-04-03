//
//  TableViewHucre.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 2.04.2022.
//

import UIKit

class TableViewHucre: UITableViewCell{

    @IBOutlet weak var yemekAdetLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var yemekAdiLabel: UILabel!
    @IBOutlet weak var yemekImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func sepettenCikarButton(_ sender: Any) {
        
    }
}
