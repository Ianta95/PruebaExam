//
//  ChartsRouter.swift
//  Prueba Viper
//
//  Created by GSSQ6LXMACD01EX on 22/04/22.
//

import UIKit

class ChartsRouter: ChartsRouterProtocols {
    static func createModule() -> UIViewController {
        let view: ChartsProtocols = ChartsViewController() as ChartsProtocols
        if let viewC = view as? ChartsViewController {
            let presenter: ChartsPresenterProtocols & ChartsInteractorOutputProtocols = ChartsPresenter()
            let interactor: ChartsInteractorInputProtocols = ChartsInteractor()
            let router: ChartsRouterProtocols = ChartsRouter()
            viewC.presenter = presenter
            presenter.view = viewC
            presenter.interactor = interactor
            presenter.router = router
            interactor.presenter = presenter
            return viewC
        }
        return UIViewController()
    }
    
    
}
