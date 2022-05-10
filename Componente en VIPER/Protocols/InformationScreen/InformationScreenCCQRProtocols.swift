//
//  InformationScreenCobrarProtocols.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 26/04/22.
//

import UIKit

protocol InformationScreenCCQRProtocols: AnyObject {
    var presenter: InformationScreenCCQRPresenterProtocols? { get set }
    var model: InformationScreenCCQRType { get set }
    
    func prepareView()
    func getContext() -> InformationScreenCCQRViewController
}

protocol InformationScreenCCQRPresenterProtocols: AnyObject {
    var view: InformationScreenCCQRProtocols? { get set }
    var router: InformationScreenCCQRRouterProtocols? { get set }
    var interactor: InformationScreenCCQRInteractorInputProtocols? { get set }
    
    func setupScrollView()
    func cellForARowSetup(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

protocol InformationScreenCCQRRouterProtocols: AnyObject {
    static func createModule(viewType: InfScreenCCQRType) -> UIViewController
    
}

protocol InformationScreenCCQRInteractorOutputProtocols: AnyObject {
    func response(data: AnyObject)
    
    func finishSetupScroll()
    func finishSetupComponents()
    func finishSetupTableview()
}

protocol InformationScreenCCQRInteractorInputProtocols: AnyObject {
    var presenter: InformationScreenCCQRPresenterProtocols? { get set }
    
    func setupScrollView(view: InformationScreenCCQRViewController, complete: () -> ())
    func setupComponents(view: InformationScreenCCQRViewController, complete: () -> ())
    func setupTableView(view: InformationScreenCCQRViewController, model: InformationScreenCCQRType, delegate: tableCDelegate, complete: () -> ())
    func cellForARowSetup(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, model: InformationScreenCCQRType) -> UITableViewCell
}
