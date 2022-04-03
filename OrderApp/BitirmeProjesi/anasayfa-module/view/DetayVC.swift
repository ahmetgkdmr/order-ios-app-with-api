//
//  DetayVC.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 1.04.2022.
//

import UIKit
import Kingfisher

class DetayVC: UIViewController {

    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekAdiLabel: UILabel!
    
    @IBOutlet weak var yemekAdetLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    var yemek:Yemekler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.wraps = true
        stepper.autorepeat = true
        yemekAdetLabel.text = "1"
        stepper.minimumValue = 1
        stepper.maximumValue = 20
        tabBar.delegate = self

        if let y = yemek {
            
            yemekAdiLabel.text = y.yemek_adi
            yemekFiyatLabel.text = "\(y.yemek_fiyat!) ₺"
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)"){
                
                DispatchQueue.main.async {
                    self.yemekImageView.kf.setImage(with:url)
                }
            
        }
        
    }
    }

    @IBOutlet weak var tabBar: UITabBar!
    @IBAction func stepperDegistir(_ sender: UIStepper) {
        
        yemekAdetLabel.text = String(Int(sender.value))
        
    }
    @IBAction func sepeteEkleButton(_ sender: Any) {
        
        if let y = yemek {
            
            let alert = UIAlertController(title: "Sepete Eklendi", message: "\(yemekAdetLabel.text!) adet \(yemekAdiLabel.text!) sepete eklendi.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            yemekEkle(yemek_adi: y.yemek_adi!, yemek_resim_adi: y.yemek_resim_adi!, yemek_fiyat: Int(y.yemek_fiyat!) ?? 0, yemek_siparis_adet: Int(yemekAdetLabel.text!) ?? 0, kullanici_adi: "ahmet_gokdemir")
            
            print("\(yemekAdetLabel.text!) adet \(y.yemek_adi!) sepete eklendi")
            
        }
        
    }
     
    func yemekEkle(yemek_adi : String, yemek_resim_adi : String, yemek_fiyat : Int, yemek_siparis_adet : Int, kullanici_adi : String) {
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php")!
        var istek = URLRequest(url: url)
        istek.httpMethod = "POST"
        let posString = "yemek_adi=\(yemek_adi)&yemek_resim_adi=\(yemek_resim_adi)&yemek_fiyat=\(yemek_fiyat)&yemek_siparis_adet=\(yemek_siparis_adet)&kullanici_adi=\(kullanici_adi)"
        istek.httpBody = posString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: istek){ data,response,error in
            if error != nil || data == nil {
                print("HATA")
                return
            }
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                    print(json)
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }

}

extension DetayVC : UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (item.tag == 1 ) {
            performSegue(withIdentifier: "detayToAnasayfa", sender: nil)
            
        }
        if (item.tag == 2 ) {
            performSegue(withIdentifier: "detayToSepet", sender: nil)
            
        }
    }
    
}
