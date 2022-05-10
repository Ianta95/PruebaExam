//
//  ConfigurationsScreenRouter.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 01/05/22.
//

import UIKit

class ConfigurationsScreenRouter: ConfigurationsScreenRouterProtocols {

    static func createModule(type: ConfigurationScreenType, delegate: ConfigurationsScreenDelegate? = nil) -> UIViewController {
        let view: ConfigurationsScreenProtocols = ConfigurationsScreenView(type: type) as ConfigurationsScreenProtocols
        if let viewC = view as? ConfigurationsScreenView {
            let presenter: ConfigurationsScreenPresenterProtocols & ConfigurationsScreenInteractorOutputProtocols = ConfigurationsScreenPresenter()
            let interactor: ConfigurationsScreenInteractorInputProtocols = ConfigurationsScreenInteractor()
            let router: ConfigurationsScreenRouterProtocols = ConfigurationsScreenRouter()
            viewC.presenter = presenter
            presenter.view = viewC
            presenter.interactor = interactor
            presenter.router = router
            presenter.delegate = delegate
            interactor.presenter = presenter
            return viewC
        }
        return UIViewController()
    }
    
    func goToOption(view: ConfigurationsScreenView, option: UIViewController, isPresent: Bool) {
        if isPresent {
            view.present(modal: option, animated: true, sizeModal: .big, completion: nil)
        } else {
            view.navigationController?.pushViewController(option, animated: true)
        }
//        option.modalPresentationStyle = .overFullScreen
//        view.present(option, animated: true, completion: nil)
       
    }
}
