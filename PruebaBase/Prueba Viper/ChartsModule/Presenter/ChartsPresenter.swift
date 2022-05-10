//
//  ChartsPresenter.swift
//  Prueba Viper
//
//  Created by GSSQ6LXMACD01EX on 22/04/22.
//

import UIKit

class ChartsPresenter: ChartsPresenterProtocols, ChartsInteractorOutputProtocols {
    var view: ChartsProtocols?
    var router: ChartsRouterProtocols?
    var interactor: ChartsInteractorInputProtocols?
    
    func response(data: AnyObject) {
        
    }
    
    func fetchData() {
        interactor?.fetchData()
    }
    
}
