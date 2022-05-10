//
//  ChartsModuleProtocols.swift
//  Prueba Viper
//
//  Created by GSSQ6LXMACD01EX on 22/04/22.
//

import UIKit

protocol ChartsProtocols: AnyObject {
    var presenter: ChartsPresenterProtocols? { get set }
    
    func prepareView()
}

protocol ChartsPresenterProtocols: AnyObject {
    var view: ChartsProtocols? { get set }
    var router: ChartsRouterProtocols? { get set }
    var interactor: ChartsInteractorInputProtocols? { get set }
    
    func fetchData()
    
}

protocol ChartsRouterProtocols: AnyObject {
    static func createModule() -> UIViewController
}

protocol ChartsInteractorOutputProtocols: AnyObject {
    func response(data: AnyObject)
}

protocol ChartsInteractorInputProtocols: AnyObject {
    var presenter: ChartsPresenterProtocols? { get set }
    
    func fetchData()
}
