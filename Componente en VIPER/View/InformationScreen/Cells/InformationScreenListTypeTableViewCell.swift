//
//  InformationScreenListTypeTableViewCell.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 27/04/22.
//

import UIKit
import GSSAVisualComponents

class InformationScreenListTypeTableViewCell: UITableViewCell {
    
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
        return view
    }()
    

    var heightContentCell: NSLayoutConstraint? = nil
    var heightTitleLbl: NSLayoutConstraint? = nil
    var titleLblHeight: CGFloat = 0
    var contentLblHeight: CGFloat = 0
    var tableView: UITableView?
    var adjustHeight: CGFloat {
        if contentCellView.isHidden {
            return titleLblHeight + 10
        } else {
            return titleLblHeight + contentLblHeight + 20
        }
    }
    var options: [InfScreenListOption] = [InfScreenListOption]()
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
        contentCellView.anchor(top: btnShow.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingBottom: 10)
        btnShow.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        heightContentCell = contentCellView.heightAnchor.constraint(equalToConstant: 0)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(text: String,  options: [InfScreenListOption], tableView: UITableView){
        lblTitle.text = text
        self.options = options
        self.tableView = tableView
        let stack = generateList()
        self.contentCellView.addSubview(stack)
        stack.anchor(top: contentCellView.topAnchor, left: contentCellView.leftAnchor, bottom: contentCellView.bottomAnchor, right: contentCellView.rightAnchor)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.beginUpdates()
        tableView.endUpdates()
        self.imgView.image = imgClose
    }
    
    override class func awakeFromNib() {
        
    }
    
    override func draw(_ rect: CGRect) {
        titleLblHeight = lblTitle.frame.height
        addSizeToArray?(contentView.frame.height)
        self.clickAdjustSize()
    }
    
    @objc func clickButton(){
        if contentCellView.isHidden {
            self.heightTitleLbl?.priority = UILayoutPriority(rawValue: 1000.00)
            self.heightTitleLbl?.constant = titleLblHeight
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
    
    private func generateList() -> UIView {
        let stView = UIView()
        var lastBottomConstraint: NSLayoutYAxisAnchor?
        var lastTopConstraint: NSLayoutYAxisAnchor?
        var count1 = 0
        for listItem in options {
            let lblTitle = GSVCLabel()
            lblTitle.styleType = 10
            lblTitle.textColorStyle = .GSVCText100
            lblTitle.numberOfLines = 0
            lblTitle.lineBreakMode = .byWordWrapping
            lblTitle.textAlignment = .left
            lblTitle.text = listItem.title
            stView.addSubview(lblTitle)
            if lastTopConstraint == nil {
               lastTopConstraint = stView.topAnchor
            }
            guard let lastTopConstraintN = lastTopConstraint else {
                return UIView()
            }
            lblTitle.anchor(top: lastTopConstraintN, left: stView.leftAnchor, right: stView.rightAnchor)
            lastTopConstraint = lblTitle.bottomAnchor
            var count2 = 0
            for liOp in listItem.listOptions {
                let spaceView = UIView()
                let lblOption = GSVCLabel()
                lblOption.text = "\u{2022}\t\(liOp)"
                lblOption.styleType = 6
                lblOption.textColorStyle = .GSVCText100
                lblOption.numberOfLines = 0
                lblOption.lineBreakMode = .byWordWrapping
                spaceView.addSubview(lblOption)
                lblOption.anchor(top: spaceView.topAnchor, left: spaceView.leftAnchor, bottom: spaceView.bottomAnchor, right: spaceView.rightAnchor, paddingLeft: 10)
                stView.addSubview(spaceView)
                guard let lastTopConstraintM = lastTopConstraint else {
                    return UIView()
                }
                spaceView.anchor(top: lastTopConstraintM, left: stView.leftAnchor, right: stView.rightAnchor)
                lastTopConstraint = spaceView.bottomAnchor
                count2 += 1
                let nextCount = count1 + 1
                if count2 == listItem.listOptions.count && nextCount == options.count {
                    spaceView.anchor(bottom: stView.bottomAnchor)
                }
            }
            count1 += 1
        }
        return stView
    }
    
}
