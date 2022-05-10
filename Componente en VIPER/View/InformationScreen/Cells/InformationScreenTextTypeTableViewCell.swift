//
//  InformationScreenTextTypeTableViewCell.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 26/04/22.
//

import UIKit
import GSSAVisualComponents

class InformationScreenTextTypeTableViewCell: UITableViewCell {
    
    let lblTitle: GSVCLabel = {
        let lbl = GSVCLabel()
        lbl.styleType = 5
        lbl.textColorStyle = .GSVCText100
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    let imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let btnShow: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        return btn
    }()
    
    lazy var contentCellView: UIView = {
        let view = UIView()
        view.addSubview(lblContent)
        lblContent.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 6, paddingLeft: 6, paddingBottom: 6, paddingRight: 6)
        return view
    }()
    
    let lblContent: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    var heightContentCell: NSLayoutConstraint? = nil
    var heightTitleLbl: NSLayoutConstraint? = nil
    var titleLblHeight: CGFloat = 0
    var contentLblHeight: CGFloat = 0
    var tableView: UITableView?
    var adjustHeight: CGFloat {
        if lblContent.isHidden {
            return titleLblHeight + 10
        } else {
            return titleLblHeight + contentLblHeight + 20
        }
    }
    var imgClose: UIImage? = UIImage(named: "row", in: Bundle(for:InformationScreenTextTypeTableViewCell.self), compatibleWith: nil)
    var addSizeToArray: ((CGFloat) -> ())? = nil
    var clickAdjustSize: () -> () = { }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(lblTitle)
        self.contentView.addSubview(contentCellView)
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(btnShow)
        imgView.anchor(top: self.contentView.topAnchor, right: self.contentView.rightAnchor, paddingTop: 10, paddingRight: 20)
        imgView.widthAnchor.constraint(equalToConstant: 11).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblTitle.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: imgView.leftAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0)
        heightTitleLbl = lblTitle.heightAnchor.constraint(equalToConstant: 100)
        heightTitleLbl?.priority = .defaultLow
        heightTitleLbl?.isActive = true
        
        btnShow.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: lblTitle.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -10, paddingRight: 0)
        contentCellView.anchor(top: btnShow.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingBottom: 6)
        btnShow.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        heightContentCell = contentCellView.heightAnchor.constraint(equalToConstant: 0)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(text: String, content: NSAttributedString, tableView: UITableView){
        lblTitle.text = text
        lblContent.attributedText = content
        self.tableView = tableView
        self.imgView.image = imgClose
    }
    
    override class func awakeFromNib() {
        
    }
    
    override func draw(_ rect: CGRect) {
        titleLblHeight = lblTitle.frame.height
        contentLblHeight = lblContent.frame.height
        addSizeToArray?(contentView.frame.height)
        self.clickAdjustSize()
    }
    
    @objc func clickButton(){
        if lblContent.isHidden {
            self.heightTitleLbl?.priority = UILayoutPriority(rawValue: 1000.00)
            self.heightTitleLbl?.constant = titleLblHeight
            self.lblContent.alpha = 1
            self.lblContent.isHidden = false
            self.contentCellView.isHidden = false
            self.heightContentCell?.isActive = false
            tableView?.rowHeight = UITableView.automaticDimension
            tableView?.beginUpdates()
            tableView?.endUpdates()
            UIView.animate(withDuration: 0.3) {
                self.imgView.transform = CGAffineTransform(rotationAngle:  CGFloat.pi)
            }
            addSizeToArray?(contentView.frame.height)
            clickAdjustSize()
        } else {
            self.heightTitleLbl?.priority = UILayoutPriority(rawValue: 1000.00)
            self.heightTitleLbl?.constant = titleLblHeight
            UIView.animate(withDuration: 0.3) {
                self.imgView.transform = CGAffineTransform.identity
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.lblContent.alpha = 0
                self.lblContent.isHidden = true
                self.contentCellView.isHidden = true
                self.heightContentCell?.isActive = true
                self.tableView?.rowHeight = UITableView.automaticDimension
                self.tableView?.beginUpdates()
                self.tableView?.endUpdates()
                self.addSizeToArray?(self.contentView.frame.height)
                self.clickAdjustSize()
            }
        }
    }
    
}
