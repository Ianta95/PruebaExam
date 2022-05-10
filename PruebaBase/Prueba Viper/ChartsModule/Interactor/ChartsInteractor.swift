//
//  ChartsInteractor.swift
//  Prueba Viper
//
//  Created by GSSQ6LXMACD01EX on 22/04/22.
//

import UIKit

class ChartsInteractor: ChartsInteractorInputProtocols {
    var presenter: ChartsPresenterProtocols?
    
    func fetchData() {
        Service.fetchBackground { color in
            
        }
    }
}
