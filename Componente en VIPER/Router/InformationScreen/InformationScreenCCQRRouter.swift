//
//  InformationScreenCCQRRouter.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 26/04/22.
//

import UIKit

class InformationScreenCCQRRouter: InformationScreenCCQRRouterProtocols {
    static func createModule(viewType: InfScreenCCQRType) -> UIViewController {
        let model = InformationScreenCCQRType(viewType: viewType)
        let view: InformationScreenCCQRProtocols = InformationScreenCCQRViewController(model: model) as InformationScreenCCQRProtocols
        if let viewC = view as? InformationScreenCCQRViewController {
            let presenter: InformationScreenCCQRPresenterProtocols & InformationScreenCCQRInteractorOutputProtocols = InformationScreenCCQRPresenter()
            let interactor: InformationScreenCCQRInteractorInputProtocols = InformationScreenCCQRInteractor()
            let router: InformationScreenCCQRRouterProtocols = InformationScreenCCQRRouter()
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
