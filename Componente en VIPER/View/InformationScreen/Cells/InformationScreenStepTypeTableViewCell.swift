//
//  InformationScreenStepTypeTableViewCell.swift
//  GSSALoans
//
//  Created by GSSQ6LXMACD01EX on 27/04/22.
//

import UIKit
import GSSAVisualComponents

class InformationScreenStepTypeTableViewCell: UITableViewCell {
    
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
    
    let lineLayer = CAShapeLayer()
    let dottedLine = UIView()
    let path = CGMutablePath()
    var lastCircle = UIView()
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
    var options: [InfScreenStepVertical] = [InfScreenStepVertical]()
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
        contentCellView.anchor(top: btnShow.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor)
        btnShow.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        heightContentCell = contentCellView.heightAnchor.constraint(equalToConstant: 0)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(text: String,  options: [InfScreenStepVertical], tableView: UITableView){
        lblTitle.text = text
        self.options = options
        self.tableView = tableView
        let stack = generateSteps()
        self.contentCellView.addSubview(stack)
        stack.anchor(top: contentCellView.topAnchor, left: contentCellView.leftAnchor, bottom: contentCellView.bottomAnchor, right: contentCellView.rightAnchor)
        self.imgView.image = imgClose
        
    }
    
    override class func awakeFromNib() {
        
    }
    
    override func draw(_ rect: CGRect) {
        titleLblHeight = lblTitle.frame.height
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: 0, y: lastCircle.center.y - 20)])
        lineLayer.path = path
        dottedLine.layer.addSublayer(lineLayer)
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
    
    private func generateSteps() -> UIView {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        var arraySteps: [InfScreenStepType] = [InfScreenStepType]()
        var arrayViews: [UIView] = [UIView]()
        var arrayCircles: [UIView] = [UIView]()
        for step in options {
            let stepContentView = UIView()
            let title = GSVCLabel()
            title.text = step.title
            title.styleType = 10
            title.textColorStyle = .GSVCText100
            title.numberOfLines = 0
            title.lineBreakMode = .byWordWrapping
            stepContentView.addSubview(title)
            title.anchor(top: stepContentView.topAnchor, left: stepContentView.leftAnchor, right: stepContentView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 10)
            arraySteps.append(step.step)
            arrayViews.append(title)
            let lblStep = GSVCLabel()
            lblStep.text = step.description
            lblStep.numberOfLines = 0
            lblStep.lineBreakMode = .byWordWrapping
            lblStep.styleType = 8
            lblStep.textColorStyle = .GSVCText200
            stepContentView.addSubview(lblStep)
            lblStep.anchor(top: title.bottomAnchor, left: stepContentView.leftAnchor, bottom: stepContentView.bottomAnchor, right: stepContentView.rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 10, paddingRight: 10)
            stackView.addArrangedSubview(stepContentView)
        }
        let view = UIView()
        let circlesContentView = UIView()
        view.addSubview(circlesContentView)
        
        circlesContentView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        circlesContentView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor)
        lineLayer.strokeColor = UIColor.gray.cgColor
        lineLayer.lineWidth = 2
        lineLayer.lineDashPattern = [4,4]
        circlesContentView.addSubview(dottedLine)
        dottedLine.centerX(inView: circlesContentView)
        dottedLine.widthAnchor.constraint(equalToConstant: 2).isActive = true
        dottedLine.anchor(top: circlesContentView.topAnchor, bottom: circlesContentView.bottomAnchor, paddingTop: 30, paddingBottom: 70)
        for step in arraySteps {
            let viewCir = UIView()
            viewCir.backgroundColor = .white
            viewCir.layer.borderWidth = 1
            viewCir.layer.borderColor = UIColor.gray.cgColor
            viewCir.setDimensions(height: 30, width: 30)
            viewCir.layer.cornerRadius = 15
            circlesContentView.addSubview(viewCir)
            viewCir.centerXToSuperview()
            let lbl = GSVCLabel()
            lbl.styleType = 10
            lbl.textColorStyle = .GSVCText200
            lbl.numberOfLines = 1
            lbl.textAlignment = .center
            switch step {
            case .numeric(let num):
                lbl.text = String(num)
            case .text(let text):
                lbl.text = text
            }
            viewCir.addSubview(lbl)
            lbl.centerXToSuperview()
            lbl.centerYToSuperview()
            arrayCircles.append(viewCir)
        }
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: circlesContentView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        var count = 0
        for circle in arrayCircles {
            circle.centerY(inView: arrayViews[count])
            count += 1
            if count == arrayCircles.count {
                lastCircle = circle
            }
        }
        
        return view
    }
    
}
