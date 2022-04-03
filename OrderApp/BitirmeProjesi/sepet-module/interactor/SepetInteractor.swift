//
//  SepetInteractor.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 2.04.2022.
//

import Foundation

class SepetInteractor : PresenterToInteractorSepetProtocol {

var sepetPresenter: InteractorToPresenterSepetProtocol?

    func tumsepettekileriAl()
    {
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php")!
        var istek = URLRequest(url: url)
        istek.httpMethod = "POST"
        let posString = "kullanici_adi=ahmet_gokdemir"
        istek.httpBody = posString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: istek){ data,response,error in
            if error != nil || data == nil {
                print("HATA")
                return
            }
            
            do{
                let cevap = try JSONDecoder().decode(YemeklerSepetCevap.self, from: data!)
                if let gelenListe = cevap.sepet_yemekler {
                    self.sepetPresenter?.preseneteraVeriGonder(sepetYemeklerListesi:gelenListe)
                }
                
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
}
