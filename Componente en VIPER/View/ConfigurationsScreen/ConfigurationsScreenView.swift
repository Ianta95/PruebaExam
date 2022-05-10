//
//  ConfigurationsScreenGenView.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 01/05/22.
//

import UIKit
import GSSAVisualComponents
import GSSAVisualTemplates

class ConfigurationsScreenView: GSVTMasterViewController, ConfigurationsScreenProtocols {
    lazy var  lblTitle: GSVCLabel = {
        let lbl = GSVCLabel()
        lbl.text = type.title
        lbl.styleType = 4
        lbl.textColorStyle = .GSVCText100
        return lbl
    }()
    
    
    
    var presenter: ConfigurationsScreenPresenterProtocols?
    var type: ConfigurationScreenType
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateNameNavigation), name: NSNotification.Name(rawValue: "mx.com.gruposalinas.GSSALoads.updateName"), object: nil)
        prepareView()
        title = "Preferencias"
    }
    
    init(type: ConfigurationScreenType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareView() {
        presenter?.setupView()
    }
    
    func getContext() -> ConfigurationsScreenView {
        return self
    }
    
    func showLoader() {
        GSVCLoader.show()
    }
    
    func hideLoader() {
        GSVCLoader.hide()
    }
    
    func showError(str: String, nsError: NSError) {
        showError(str: str, nsError: nsError)
    }
    @objc func updateNameNavigation() {
        prepareView()
    }
    
}
