//
//  ConfigurationsScreenPresenter.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 01/05/22.
//

import UIKit

protocol ConfigurationsScreenDelegate: AnyObject {
    func configurationsScreen(clickInSwitch option: ConfigurationsScreenOptions, switch: UISwitch, indexN: Int)
}

class ConfigurationsScreenPresenter: ConfigurationsScreenPresenterProtocols, ConfigurationsScreenInteractorOutputProtocols {
    var view: ConfigurationsScreenProtocols?
    var router: ConfigurationsScreenRouterProtocols?
    var interactor: ConfigurationsScreenInteractorInputProtocols?
    weak var delegate: ConfigurationsScreenDelegate?
    
    func response(data: AnyObject) {
        
    }
    
    func setupView() {
        guard let view = view else { return }
        interactor?.configureView(view: view.getContext(), startFunction: startFunction(switchC:indexN:))
    }
    
    func goToOption(indexN: Int) {
        guard let view = view else { return }
        let controller = view.type.controllers[indexN]
        let isPresent = view.type.isPresentOrPush[indexN]
        router?.goToOption(view: view.getContext(), option: controller, isPresent: isPresent)
    }
    
    func clickSwitch(option: ConfigurationsScreenOptions, switchC: UISwitch, indexN: Int) {
        delegate?.configurationsScreen(clickInSwitch: option, switch: switchC, indexN: indexN)
        guard let view = view else { return }
        let function = view.type.switchActions[indexN]
        function?(view.getContext(), switchC)
    }
    
    func clickInformativeImage(option: ConfigurationsScreenOptions, indexN: Int) {
        guard let view = view else { return }
        let function = view.type.actions[indexN]
        function?(view.getContext())
    }
    
    func startFunction(switchC: UISwitch, indexN: Int) {
        guard let view = view else { return }
        let function = view.type.startActions[indexN]
        function?(view.getContext(), switchC)
    }
}
