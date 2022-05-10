//
//  ChartsViewController.swift
//  Prueba Viper
//
//  Created by GSSQ6LXMACD01EX on 22/04/22.
//

import UIKit

class ChartsViewController: UIViewController, ChartsProtocols {
    var presenter: ChartsPresenterProtocols?
    
    override func viewDidLoad() {
        prepareView()
        self.view.backgroundColor = .red
    }
    
    
    
    func prepareView() {
        presenter?.fetchData()
    }
    
}
