//
//  ConfigurationsScreenProtocols.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 01/05/22.
//

import UIKit

protocol ConfigurationsScreenProtocols: AnyObject {
    var presenter: ConfigurationsScreenPresenterProtocols? { get set }
    var type: ConfigurationScreenType { get set }
   
    func prepareView()
    func getContext() -> ConfigurationsScreenView
    func showLoader()
    func hideLoader()
    func showError(str: String, nsError: NSError)
}

protocol ConfigurationsScreenPresenterProtocols: AnyObject {
    var view: ConfigurationsScreenProtocols? { get set }
    var router: ConfigurationsScreenRouterProtocols? { get set }
    var interactor: ConfigurationsScreenInteractorInputProtocols? { get set }
    var delegate: ConfigurationsScreenDelegate? { get set }
    
    func setupView()
    func goToOption(indexN: Int)
    func clickSwitch(option: ConfigurationsScreenOptions, switchC: UISwitch, indexN: Int)
    func clickInformativeImage(option: ConfigurationsScreenOptions, indexN: Int)
}

protocol ConfigurationsScreenRouterProtocols: AnyObject {
    
    static func createModule(type: ConfigurationScreenType, delegate: ConfigurationsScreenDelegate?) -> UIViewController
    func goToOption(view: ConfigurationsScreenView, option: UIViewController, isPresent: Bool)
}

protocol ConfigurationsScreenInteractorOutputProtocols: AnyObject {
    func response(data: AnyObject)
    func startFunction(switchC: UISwitch, indexN: Int)
    
}

protocol ConfigurationsScreenInteractorInputProtocols: AnyObject {
    var presenter: ConfigurationsScreenPresenterProtocols? { get set }
    
    func configureView(view: ConfigurationsScreenView, startFunction: (UISwitch, Int) -> ())
}
