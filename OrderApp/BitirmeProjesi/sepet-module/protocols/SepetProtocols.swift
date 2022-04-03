//
//  SepetProtocols.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 2.04.2022.
//

import Foundation

protocol ViewToPresenterSepetProtocol {//Presenter Katmanı
    var sepetInteractor:PresenterToInteractorSepetProtocol? {get set}
    var sepetView:PresenterToViewSepetProtocol? {get set}
    
    func sepettekileriYukle()

}

protocol PresenterToInteractorSepetProtocol {//Interactor Katmanı
    var sepetPresenter:InteractorToPresenterSepetProtocol? {get set}
    
    func tumsepettekileriAl()

}

protocol InteractorToPresenterSepetProtocol {
    func preseneteraVeriGonder(sepetYemeklerListesi:Array<YemeklerSepet>)
}

protocol PresenterToViewSepetProtocol {
    func vieweVeriGonder(sepetYemeklerListesi:Array<YemeklerSepet>)
}

protocol PresenterToRouterSepetProtocol {
    static func createModule(ref:SepetVC)
}
