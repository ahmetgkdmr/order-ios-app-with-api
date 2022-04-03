//
//  SepetPresenter.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 2.04.2022.
//

import Foundation

class SepetPresenter : ViewToPresenterSepetProtocol {
    var sepetInteractor: PresenterToInteractorSepetProtocol?
    var sepetView: PresenterToViewSepetProtocol?
    
    func sepettekileriYukle() {
        sepetInteractor?.tumsepettekileriAl()
    }
}

extension SepetPresenter : InteractorToPresenterSepetProtocol {
    func preseneteraVeriGonder(sepetYemeklerListesi: Array<YemeklerSepet>) {
        sepetView?.vieweVeriGonder(sepetYemeklerListesi: sepetYemeklerListesi)
    }
}
