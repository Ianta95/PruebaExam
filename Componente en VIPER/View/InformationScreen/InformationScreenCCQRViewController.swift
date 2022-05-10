//
//  InformationScreenCCQRViewController.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 26/04/22.
//

import UIKit
import GSSAVisualComponents

class InformationScreenCCQRViewController: UIViewController, InformationScreenCCQRProtocols {
    
    // MARK: Components
    lazy var headerView: UIView = {
        let view = UIView()
        let lblTitle = GSVCLabel()
        lblTitle.text = model.titleForHeader
        lblTitle.textColor = .black
        lblTitle.textAlignment = .center
        lblTitle.styleType = 7
        view.addSubview(btnCloseHeader)
        btnCloseHeader.anchor(right: view.rightAnchor, paddingRight: 30)
        btnCloseHeader.centerYToSuperview()
        btnCloseHeader.setImage(UIImage(named: "closeSAIcon")?.withRenderingMode(.alwaysTemplate).tint(with: UIColor.GSVCSecundary200), for: .normal)
        view.addSubview(lblTitle)
        lblTitle.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 6, paddingLeft: 6, paddingBottom: 6, paddingRight: 6)
        return view
    }()
    
    let btnCloseHeader: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setDimensions(height: 26, width: 26)
        return btn
    }()
    
    lazy var imgViewHeader: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: model.imageName, in: Bundle(for: InformationScreenCCQRViewController.self), compatibleWith: nil)
        return view
    }()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let tableView = UITableView()
    let btnExit: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.setTitle("Salir", for: .normal)
        btn.titleLabel?.textColor = UIColor.GSVCSecundary100
        return btn
    }()
    
    
    // MARK: Properties
    var presenter: InformationScreenCCQRPresenterProtocols?
    var model: InformationScreenCCQRType
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        prepareView()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    init(model: InformationScreenCCQRType){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareView() {
        prepareUI()
    }
    
    
    func getContext() -> InformationScreenCCQRViewController {
        return self
    }
    
    func prepareUI(){
        presenter?.setupScrollView()
    }
    
}

extension InformationScreenCCQRViewController: tableCDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.contentCCQRTType.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        return presenter.cellForARowSetup(tableView, cellForRowAt: indexPath)
    }
    
}
