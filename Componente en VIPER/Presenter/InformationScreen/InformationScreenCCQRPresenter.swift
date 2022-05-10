//
//  InformationScreenCCQRPresenter.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 26/04/22.
//

import UIKit

class InformationScreenCCQRPresenter: InformationScreenCCQRPresenterProtocols, InformationScreenCCQRInteractorOutputProtocols {

    var view: InformationScreenCCQRProtocols?
    var router: InformationScreenCCQRRouterProtocols?
    var interactor: InformationScreenCCQRInteractorInputProtocols?
    
    func response(data: AnyObject) {
        
    }
    
    
    // MARK: Presenter functions
    func setupScrollView() {
        guard let view = view else { return }
        interactor?.setupScrollView(view: view.getContext(), complete: finishSetupScroll)
    }
    
    func cellForARowSetup(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let view = view else { return UITableViewCell() }
        if let interactor = interactor {
            return interactor.cellForARowSetup(tableView, cellForRowAt: indexPath, model: view.model)
        }
        return UITableViewCell()
    }
    
    // MARK: Output functions
    
    func finishSetupScroll() {
        guard let view = view else { return }
        interactor?.setupComponents(view: view.getContext(), complete: finishSetupComponents)
    }
    
    func finishSetupComponents() {
        guard let view = view else { return }
        guard let delegate = view.getContext() as? tableCDelegate else { return }
        interactor?.setupTableView(view: view.getContext(), model: view.model, delegate: delegate, complete: finishSetupTableview)
    }
    
    func finishSetupTableview() {
        
    }
    
    
    
}
