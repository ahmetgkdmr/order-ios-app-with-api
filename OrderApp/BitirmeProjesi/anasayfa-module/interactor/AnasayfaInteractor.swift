//
//  AnasayfaInteractor.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 1.04.2022.
//

import Foundation

class AnasayfaInteractor : PresenterToInteractorAnasayfaProtocol {

var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?

func tumyemekleriAl() {
    let url = URL(string: "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php")!
    
    URLSession.shared.dataTask(with: url){ data,response,error in
        if error != nil || data == nil {
            print("HATA")
            return
        }
        
        do{
            let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data!)
            
            if let gelenListe = cevap.yemekler {
                self.anasayfaPresenter?.preseneteraVeriGonder(yemeklerListesi: gelenListe)
            }
        }catch{
            print(error.localizedDescription)
        }
    }.resume()
    
    
}
}
