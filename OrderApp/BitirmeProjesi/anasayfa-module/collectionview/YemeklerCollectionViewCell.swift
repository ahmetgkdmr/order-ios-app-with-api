//
//  YemeklerCollectionViewCell.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 1.04.2022.
//

import UIKit

protocol HucreProtocol {
    func sepeteEkleTikla(indexPath:IndexPath)
}

class YemeklerCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var yemekImageView: UIImageView!
    
    
    
    @IBOutlet weak var yemekAdiLabel: UILabel!
    
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    
    var hucreProtocol:HucreProtocol?
    var indexPath:IndexPath?
    
    
    @IBAction func yemekInceleButton(_ sender: Any) {
        
        hucreProtocol?.sepeteEkleTikla(indexPath: indexPath!)
        
    }
    
}
