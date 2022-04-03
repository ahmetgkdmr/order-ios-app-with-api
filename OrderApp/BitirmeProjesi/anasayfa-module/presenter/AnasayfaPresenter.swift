//
//  AnasayfaPresenter.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 1.04.2022.
//

import Foundation

class AnasayfaPresenter : ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func yemekleriYukle() {
        anasayfaInteractor?.tumyemekleriAl()
    }
}

extension AnasayfaPresenter : InteractorToPresenterAnasayfaProtocol {
    func preseneteraVeriGonder(yemeklerListesi: Array<Yemekler>) {
        anasayfaView?.vieweVeriGonder(yemeklerListesi: yemeklerListesi)
    }
}
