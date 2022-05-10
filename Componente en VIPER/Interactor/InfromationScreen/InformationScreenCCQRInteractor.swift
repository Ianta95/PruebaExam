//
//  InformationScreenCCQRInteractor.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 26/04/22.
//

import UIKit

class InformationScreenCCQRInteractor: InformationScreenCCQRInteractorInputProtocols {
    
    var presenter: InformationScreenCCQRPresenterProtocols?
    var viewB: InformationScreenCCQRViewController?
    var constraintC: NSLayoutConstraint? = nil
    var totalSize: CGFloat? = nil
    
    func setupScrollView(view: InformationScreenCCQRViewController, complete: () -> ()) {
        view.scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.contentView.translatesAutoresizingMaskIntoConstraints = false
        view.view.addSubview(view.scrollView)
        view.scrollView.addSubview(view.contentView)
        
        view.scrollView.centerXAnchor.constraint(equalTo: view.view.centerXAnchor).isActive = true
        view.scrollView.widthAnchor.constraint(equalTo: view.view.widthAnchor).isActive = true
        view.scrollView.topAnchor.constraint(equalTo: view.view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.scrollView.bottomAnchor.constraint(equalTo: view.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        view.contentView.centerXAnchor.constraint(equalTo: view.scrollView.centerXAnchor).isActive = true
        view.contentView.widthAnchor.constraint(equalTo: view.scrollView.widthAnchor).isActive = true
        view.contentView.topAnchor.constraint(equalTo: view.scrollView.topAnchor).isActive = true
        view.contentView.bottomAnchor.constraint(equalTo: view.scrollView.bottomAnchor).isActive = true
        viewB = view
        guard let viewType = viewB?.model.viewType else { return }
        switch viewType {
        case .DigitalCard:
            constraintC = view.contentView.heightAnchor.constraint(equalToConstant: view.model.heightTotal)
            constraintC!.isActive = true
        case .FrozenCard:
            constraintC = view.contentView.heightAnchor.constraint(equalToConstant: view.model.heightTotal)
            constraintC!.isActive = true
        }
        complete()
    }
    
    func setupComponents(view: InformationScreenCCQRViewController, complete: () -> ()) {
        view.contentView.addSubview(view.headerView)
        view.headerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.headerView.anchor(top: view.contentView.safeAreaLayoutGuide.topAnchor, left: view.contentView.leftAnchor, right: view.contentView.rightAnchor)
        view.contentView.addSubview(view.imgViewHeader)
        view.imgViewHeader.anchor(top: view.headerView.bottomAnchor, left: view.contentView.leftAnchor, right: view.contentView.rightAnchor, paddingTop: 26, paddingLeft: 80, paddingRight: 80)
        view.imgViewHeader.heightAnchor.constraint(equalTo: view.imgViewHeader.widthAnchor, multiplier: 1.0/1.0).isActive = true
        view.contentView.addSubview(view.btnExit)
        view.btnExit.anchor(left: view.contentView.leftAnchor, bottom: view.contentView.bottomAnchor, right: view.contentView.rightAnchor, paddingLeft: 30, paddingBottom: 20, paddingRight: 30)
        view.btnExit.addTarget(self, action: #selector(clickExit), for: .touchUpInside)
        view.btnCloseHeader.addTarget(self, action: #selector(clickExit), for: .touchUpInside)
        
        complete()
    }
    
    func setupTableView(view: InformationScreenCCQRViewController, model: InformationScreenCCQRType, delegate: tableCDelegate, complete: () -> ()) {
        for _ in model.contentCCQRTType.content {
            view.model.heightAsigned.append(0.0)
        }
        view.view.addSubview(view.tableView)
        view.tableView.translatesAutoresizingMaskIntoConstraints = false
        view.tableView.anchor(top: view.imgViewHeader.bottomAnchor, left: view.contentView.leftAnchor, bottom: view.btnExit.topAnchor, right: view.contentView.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingBottom: 30, paddingRight: 30)
        view.tableView.delegate = delegate
        view.tableView.dataSource = delegate
        view.tableView.register(InformationScreenTextTypeTableViewCell.self, forCellReuseIdentifier: INF_SCREEN_ONLY_TEXT_TABLEVIEW_CELL)
        view.tableView.register(InformationScreenStepTypeTableViewCell.self, forCellReuseIdentifier: INF_SCREEN_STEP_TYPE_TABLEVIEW_CELL)
        view.tableView.register(InformationScreenListTypeTableViewCell.self, forCellReuseIdentifier: INF_SCREEN_LIST_TYPE_TABLEVIEW_CELL)
        complete()
    }
    
    func cellForARowSetup(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, model: InformationScreenCCQRType) -> UITableViewCell {
        switch model.contentCCQRTType.content[indexPath.row] {
        case .stepVertical(title: let title, options: let options):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: INF_SCREEN_STEP_TYPE_TABLEVIEW_CELL, for: indexPath) as? InformationScreenStepTypeTableViewCell else { return UITableViewCell() }
            cell.setup(text: title, options: options, tableView: tableView)
            cell.addSizeToArray = { size in
                self.viewB?.model.heightAsigned[indexPath.row] = size
            }
            cell.clickAdjustSize = {
                guard let viewB = self.viewB else {
                    return
                }
                self.adjustHeight(sizeArrays: viewB.model.heightAsigned)
            }
            return cell
        case .listOption(title: let title, options: let options):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: INF_SCREEN_LIST_TYPE_TABLEVIEW_CELL, for: indexPath) as? InformationScreenListTypeTableViewCell else { return UITableViewCell() }
            cell.setup(text: title, options: options, tableView: tableView)
            cell.addSizeToArray = { size in
                self.viewB?.model.heightAsigned[indexPath.row] = size
            }
            cell.clickAdjustSize = {
                guard let viewB = self.viewB else {
                    return
                }
                self.adjustHeight(sizeArrays: viewB.model.heightAsigned)
            }
            return cell
        case .onlyText(title: let title, text: let text):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: INF_SCREEN_ONLY_TEXT_TABLEVIEW_CELL, for: indexPath) as? InformationScreenTextTypeTableViewCell else { return UITableViewCell() }
            cell.setup(text: title, content: text, tableView: tableView)
            cell.addSizeToArray = { size in
                self.viewB?.model.heightAsigned[indexPath.row] = size
            }
            cell.clickAdjustSize = {
                guard let viewB = self.viewB else {
                    return
                }
                self.adjustHeight(sizeArrays: viewB.model.heightAsigned)
            }
            return cell
        }
        
    }
    
    @objc func clickExit() {
        viewB?.navigationController?.popViewController(animated: true)
    }
    
    func adjustHeight(sizeArrays: [CGFloat]) {
        var sizeT: CGFloat = 0
        for size in sizeArrays {
            if size == 0 {
                return
            }
            sizeT += size
        }
        if let totalSizeD = totalSize {
            if sizeT >= totalSizeD {
                self.totalSize = sizeT
                guard let fullSize = viewB?.model.heightTotal else { return }
                constraintC?.constant = fullSize
            } else {
                if sizeT == totalSizeD {
                    guard let fullSize = viewB?.model.heightTotal else { return }
                    constraintC?.constant = fullSize
                } else {
                    guard let fullSize = viewB?.model.heightTotal else { return }
                    let difNow = (totalSizeD - sizeT)
                    guard let constraintC = constraintC else {
                        return
                    }
                    
                    constraintC.constant = fullSize - difNow
                }
            }
        } else {
            self.totalSize = sizeT
        }
    }
    
}

typealias tableCDelegate = UITableViewDelegate & UITableViewDataSource


