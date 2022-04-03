//
//  DetayProtocols.swift
//  BitirmeProjesi
//
//  Created by ahmet gökdemir on 3.04.2022.
//

import Foundation

protocol ViewToPresenterDetayProtocol {//Presenter Katmanı
    var anasayfaInteractor:PresenterToInteractorAnasayfaProtocol? {get set}
    
    func sepeteYukle()

}

protocol PresenterToInteractorDetayProtocol {//Interactor Katmanı
    var detayPresenter:InteractorToPresenterDetayProtocol? {get set}
    
    func sepeteEkle()

}

protocol PresenterToRouterDetayProtocol {
    static func createModule(ref:DetayVC)
}
