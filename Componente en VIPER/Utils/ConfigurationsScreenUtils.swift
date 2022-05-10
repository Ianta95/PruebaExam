//
//  ConfigurationsScreenUtils.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 01/05/22.
//

import UIKit
import GSSAVisualComponents
import GSSAVisualTemplates

enum ConfigurationScreenType {
    case CREDITO_BANCO_AZTECA_CON_CARGO
    case CREDITO_BANCO_AZTECA_SIN_CARGO
    case TARJETA_DE_CREDITO
    
    
    var content: [ConfigurationsScreenOptions] {
        switch self {
        case .CREDITO_BANCO_AZTECA_CON_CARGO:
            return [ConfigurationsScreenOptions(title: "Personalizar", image: "iconPaint", type: .NORMAL), ConfigurationsScreenOptions(title: "Cargo automático", image: "information", type: .SWITCH(defaultIsOn: false))]
        case .CREDITO_BANCO_AZTECA_SIN_CARGO:
            return [ConfigurationsScreenOptions(title: "Personalizar", image: "iconPaint", type: .NORMAL)]
        case .TARJETA_DE_CREDITO:
            return [ConfigurationsScreenOptions(title: "Personalizar", image: "iconPaint", type: .NORMAL), ConfigurationsScreenOptions(title: "Congelar", image: "iconIce", type: .NORMAL),
                ConfigurationsScreenOptions(title: "Estados de cuenta", image: "iconDocument", type: .NORMAL)
            ]
        }
    }
    
    var actions: [((ConfigurationsScreenView) -> ())?] {
        switch self {
        case .CREDITO_BANCO_AZTECA_CON_CARGO:
            return [nil, { view in
                let modalInfo = TooltipViewControllerViewController()
                        modalInfo.strTitle = "Información legal de la promoción."
                        modalInfo.strContent = "Crédito en Efectivo (CREDIMAX) y esta promoción son ofrecidos por Banco Azteca S.A., IBM, consulta CAT, comisiones y requisitos en su sitio web oficial. TyC de la App y de los productos y servicios en baz.app/legales."
                        view.present(modal: modalInfo, animated: true, sizeModal: .small, completion: nil)
            }]
        case .CREDITO_BANCO_AZTECA_SIN_CARGO:
            return [nil]
        case .TARJETA_DE_CREDITO:
            return [nil, nil, nil]
        }
    }
    
    var switchActions: [((ConfigurationsScreenView, UISwitch) -> ())?] {
        switch self {
        case .CREDITO_BANCO_AZTECA_CON_CARGO:
            return [nil, { view, switchC in
                // Aqui consumo de servicio
                let servicio = GSSAAutomaticChargeService()
                if switchC.isOn {
                    servicio.afiliate { bSucces, strFolio, nsError in
                        if bSucces {
                            switchC.isOn = bSucces
                        } else {
                            view.showError(str: strFolio, nsError: nsError)
                        }
                    }
                } else {
                    servicio.cancel { bSucces, strFolio, nsError in
                        if bSucces {
                            switchC.isOn = !bSucces
                        } else {
                            view.showError(str: strFolio, nsError: nsError)
                        }
                    }
                }
            }]
        case .CREDITO_BANCO_AZTECA_SIN_CARGO:
            return [nil]
        case .TARJETA_DE_CREDITO:
            return [nil, nil, nil]
        }
    }
    var startActions: [((ConfigurationsScreenView, UISwitch?) -> ())?] {
        switch self {
        case .CREDITO_BANCO_AZTECA_CON_CARGO:
            return [nil, { view, switchC in
                let servicio = GSSAAutomaticChargeService()
                servicio.seach { objRes, bSucces, nsError in
                    view.hideLoader()
                    if bSucces {
                        let iEstatus = objRes?.resultado.idEstatus ?? 0
                        guard let switchC = switchC else { return }
                        switchC.isOn = iEstatus == 1
                    } else {
                        view.showError(str: objRes?.folio ?? "", nsError: nsError)
                    }
                }
            }]
        case .CREDITO_BANCO_AZTECA_SIN_CARGO:
            return [nil]
        case .TARJETA_DE_CREDITO:
            return [nil, nil, nil]
        }
    }
    
    var title: String {
        switch self {
        case .CREDITO_BANCO_AZTECA_CON_CARGO, .CREDITO_BANCO_AZTECA_SIN_CARGO:
            if let name = UserDefaults.standard.value(forKey: "nameByUser") as? String {
                return name
            } else {
                return "Crédito Banco Azteca"
            }
        case .TARJETA_DE_CREDITO:
            if let name = UserDefaults.standard.value(forKey: "nameByUser") as? String {
                return name
            } else {
                return "Tarjeta de crédito"
            }
        }
    }
    
    var controllers: [UIViewController] {
        switch self {
        case .CREDITO_BANCO_AZTECA_CON_CARGO:
            return [
                GSSACustomProfileViewController(flowIsTDC: true),
                UIViewController()
            ]
        case .CREDITO_BANCO_AZTECA_SIN_CARGO:
            return [
                GSSACustomProfileViewController(flowIsTDC: true)
            ]
        case .TARJETA_DE_CREDITO:
            return [
                GSSACustomProfileViewController(flowIsTDC: true),
                FreezeCard(),
                GSSAStatementsTDCWireFrame.createGSSAStatementsTDCModule(fecha: GSSALRepository.strCardCorteDate, numCon: GSSALRepository.strNumContrato.createNumContrato())
            ]
        }
    }
    var isPresentOrPush: [Bool] {
        switch self {
        case .CREDITO_BANCO_AZTECA_CON_CARGO:
            return [
                false,
                true
            ]
        case .CREDITO_BANCO_AZTECA_SIN_CARGO:
            return [
                false
            ]
        case .TARJETA_DE_CREDITO:
            return [
                false,
                false,
                false
            ]
        }
    }
}

struct ConfigurationsScreenOptions {
    var title: String
    var image: String
    var type: ConfigurationsScreenOptionsType
    
    init(title: String, image: String, type: ConfigurationsScreenOptionsType){
        self.title = title
        self.image = image
        self.type = type
    }
}

enum ConfigurationsScreenOptionsType {
    case NORMAL
    case SWITCH(defaultIsOn: Bool = false)
    case INPUT
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        @objc class ClosureSleeve: NSObject {
            let closure:()->()
            init(_ closure: @escaping()->()) { self.closure = closure }
            @objc func invoke() { closure() }
        }
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
