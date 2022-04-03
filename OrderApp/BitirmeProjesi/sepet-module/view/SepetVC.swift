//
//  SepetVC.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 2.04.2022.
//

import UIKit

class SepetVC: UIViewController {

    @IBOutlet weak var yemeklerTableView: UITableView!
    
    @IBOutlet weak var sepetTutarLabel: UILabel!
    var yemeklerSepetListe = [YemeklerSepet]()
    var sepetPresenterNesnesi:ViewToPresenterSepetProtocol?
    
    var sepetYemeklerListesi = [YemeklerSepet]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tabBar.delegate = self
        yemeklerTableView.delegate = self
        yemeklerTableView.dataSource = self
        
        SepetRouter.createModule(ref: self)
        sepetPresenterNesnesi?.sepettekileriYukle()
    }
    
    @IBOutlet weak var tabBar: UITabBar!
    

}

extension SepetVC : UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,PresenterToViewSepetProtocol{
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (item.tag == 2 ) {
            performSegue(withIdentifier: "sepetToAnasayfa", sender: nil)
            
        }
    }
    
    
    func vieweVeriGonder(sepetYemeklerListesi: Array<YemeklerSepet>) {
        self.sepetYemeklerListesi = sepetYemeklerListesi
        DispatchQueue.main.async {
            self.yemeklerTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sepetYemeklerListesi.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let yemek = sepetYemeklerListesi[indexPath.row]
        let hucre = tableView.dequeueReusableCell(withIdentifier: "yemeklerHucre", for: indexPath) as! TableViewHucre
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
            
            DispatchQueue.main.async {
                hucre.yemekImageView.kf.setImage(with:url)
            }
            
        }
        var toplam = 0
        for data in sepetYemeklerListesi {
            
            toplam = toplam + ((Int(data.yemek_fiyat!) ?? 0) * (Int(data.yemek_siparis_adet!) ?? 0))
            
        }
        
        sepetTutarLabel.text = "SEPET TUTARI : \(String(toplam)) ₺"
        
        hucre.yemekAdiLabel.text = yemek.yemek_adi!
        hucre.yemekFiyatLabel.text = "\(String((Int(yemek.yemek_fiyat!) ?? 0)*(Int(yemek.yemek_siparis_adet!) ?? 0))) ₺"
        hucre.yemekAdetLabel.text = "\(yemek.yemek_siparis_adet!) adet"
        
        return hucre
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){
            (contextualAction,view,bool) in
            
            let yemek = self.sepetYemeklerListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(yemek.yemek_adi!) silinsin mi ? ", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel){
                action in }
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){
                action in
                
                let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php")!
                var istek = URLRequest(url: url)
                istek.httpMethod = "POST"
                let posString = "sepet_yemek_id=\(yemek.sepet_yemek_id!)&kullanici_adi=ahmet_gokdemir"
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
                self.sepetPresenterNesnesi?.sepettekileriYukle()
                tableView.reloadData()
                
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
  
    
}
