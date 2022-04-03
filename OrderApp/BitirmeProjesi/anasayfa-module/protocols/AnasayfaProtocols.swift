//
//  AnasayfaProtocols.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 1.04.2022.
//

import Foundation

protocol ViewToPresenterAnasayfaProtocol {//Presenter Katmanı
    var anasayfaInteractor:PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView:PresenterToViewAnasayfaProtocol? {get set}
    
    func yemekleriYukle()

}

protocol PresenterToInteractorAnasayfaProtocol {//Interactor Katmanı
    var anasayfaPresenter:InteractorToPresenterAnasayfaProtocol? {get set}
    
    func tumyemekleriAl()

}

protocol InteractorToPresenterAnasayfaProtocol {
    func preseneteraVeriGonder(yemeklerListesi:Array<Yemekler>)
}

protocol PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemeklerListesi:Array<Yemekler>)
}

protocol PresenterToRouterAnasayfaProtocol {
    static func createModule(ref:AnasayfaVC)
}
