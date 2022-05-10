//
//  InformationScreenCCQREntities.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 26/04/22.
//

import UIKit

enum InfScreenCCQRType {//prueba
    case DigitalCard
    case FrozenCard
}

struct InformationScreenCCQRType {
    
    var viewType: InfScreenCCQRType
    var imageName: String {
        switch viewType {
        case .DigitalCard:
            return "infoDigitalCard"
        case .FrozenCard:
            return "infoFreezeCard"
        }
    }
    
    var titleForHeader: String {
        switch viewType {
        case .DigitalCard:
            return "Tarjeta Digital"
        case .FrozenCard:
            return "Congelar"
        }
    }
    
    var heightTotal: CGFloat {
        switch viewType {
        case .DigitalCard:
            return 1420
        case .FrozenCard:
            return 930
        }
    }
    var heightAsigned: [CGFloat] = [CGFloat]()
    
    var contentCCQRTType: InfScreenContentOptions {
         
        switch viewType {
        case .DigitalCard:
            var attributted = NSMutableAttributedString()
                .normal("Para hacer ")
                .bold("compras seguras en internet ")
                .normal("protegiendo tu información de fraudes o clonaciones. Tu tarjeta digital tiene otro número y un código de seguridad (CVV).")
            return InfScreenContentOptions(content: [
                /*.onlyText(title: "¿Para que sirve la tarjeta digital?", text: NSMutableAttributedString()
                            "Para hacer compras seguras en internet protegiendo tu información de fraudes o clonaciones. Tu tarjeta digital tiene otro número y un código de seguridad (CVV)."),*/
                .onlyText(title: "¿Para que sirve la tarjeta digitar?", text: attributted),
                .stepVertical(title: "¿Cómo usar la tarjeta digital?", options: [
                    InfScreenStepVertical(title: "Copia el número de tarjeta y fecha de vencimiento", step: .numeric(num: 1), description: "Ingresa los datos en la web o app de compra"),
                    InfScreenStepVertical(title: "Copia el número de tarjeta y fecha de vencimiento", step: .numeric(num: 2), description: "Ingresa los datos en la web o app de compra"),
                    InfScreenStepVertical(title: "Copia el número de tarjeta y fecha de vencimiento", step: .numeric(num: 3), description: "Ingresa los datos en la web o app de compra"),
                    InfScreenStepVertical(title: "Copia el número de tarjeta y fecha de vencimiento", step: .numeric(num: 4), description: "Ingresa los datos en la web o app de compra"),
                    InfScreenStepVertical(title: "Copia el número de tarjeta y fecha de vencimiento", step: .numeric(num: 5), description: "Ingresa los datos en la web o app de compra")
                ]),
                .listOption(title: "¿Qué pasa si congelo la tarjeta digital?", options: [
                    InfScreenListOption(title: "Se detendrán", listOptions: [
                        "Se detendrán nuevos cargos y compras por internet"
                    ]),
                    InfScreenListOption(title: "No se detendrán", listOptions: [
                        "Rembolsos",
                        "Subscripciónes",
                        "Domiciliaciones"
                    ])
                ])
            ])
        case .FrozenCard:
            return InfScreenContentOptions(content: [
                .listOption(title: "¿Qué pasa si congelo la tarjeta física?", options: [
                    InfScreenListOption(title: "Se detendrán:", listOptions: [
                        "Retiros en cajeros automáticos (ATM)",
                        "Pagos en tiendas físicas",
                        "Apple Pay, Google Pay, Paypal..."
                    ]),
                    InfScreenListOption(title: "No se detendrán", listOptions: [
                        "Enviar y recibir dinero dentro de baz",
                        "Subscripciónes",
                        "Domiciliaciones",
                        "Rembolsos"
                    ])
                ]),
                .listOption(title: "¿Qué pasa si congelo la tarjeta digital?", options: [
                    InfScreenListOption(title: "Se detendrán:", listOptions: [
                        "Nuevos cargos y compras por internet"
                    ]),
                    InfScreenListOption(title: "No se detendrán", listOptions: [
                        "Rembolsos",
                        "Subscripciónes",
                        "Domiciliaciones"
                    ])
                ])
            ])
        }
    }
    
    init(viewType: InfScreenCCQRType) {
        self.viewType = viewType
    }
    
}

enum InfScreenCTableType {
    case stepVertical(title: String, options: [InfScreenStepVertical])
    case listOption(title: String, options: [InfScreenListOption])
    case onlyText(title: String, text: NSAttributedString)
}

struct InfScreenContentOptions {
    var content: [InfScreenCTableType]
    
    init(content: [InfScreenCTableType]) {
        self.content = content
    }
}

enum InfScreenStepType {
    case numeric(num: Int)
    case text(text: String)
}

struct InfScreenListOption{
    var title: String
    var listOptions: [String]
    
    init(title: String, listOptions: [String]) {
        self.title = title
        self.listOptions = listOptions
    }
}

struct InfScreenStepVertical {
    var title: String
    var step: InfScreenStepType
    var description: String
}

struct InfScreenContentTable {
    var type: InfScreenCTableType
    
    init(type: InfScreenCTableType){
        self.type = type
    }
}

let INF_SCREEN_ONLY_TEXT_TABLEVIEW_CELL = "textTypeISTableViewCell"
let INF_SCREEN_STEP_TYPE_TABLEVIEW_CELL = "stepTypeISTableViewCell"
let INF_SCREEN_LIST_TYPE_TABLEVIEW_CELL = "listTypeISTableViewCell"

extension NSMutableAttributedString {
    var fontSize:CGFloat { return 14 }
    var boldFont:UIFont { return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
    
    func bold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func blackHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
