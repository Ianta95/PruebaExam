
import UIKit
import GSSAVisualComponents

class ConfigurationsScreenInteractor: ConfigurationsScreenInteractorInputProtocols {
    
    
    var presenter: ConfigurationsScreenPresenterProtocols?
    var listTags: [String] = [String]()
    var listCells: [UIView] = [UIView]()
    var listTypes: [ConfigurationsScreenOptions] = [ConfigurationsScreenOptions]()
    
    func configureView(view: ConfigurationsScreenView, startFunction: (UISwitch, Int) -> ()) {
        view.view.addSubview(view.lblTitle)
        view.view.backgroundColor = .white
        view.lblTitle.anchor(top: view.view.safeAreaLayoutGuide.topAnchor, left: view.view.leftAnchor, right: view.view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingRight: 30)
        view.lblTitle.textAlignment = .left
        let contentView = generateOptions(view: view)
        view.view.addSubview(contentView)
        contentView.anchor(top: view.lblTitle.bottomAnchor, left: view.lblTitle.leftAnchor, right: view.lblTitle.rightAnchor, paddingTop: 30)
        contentView.isUserInteractionEnabled = true
        for cell in listCells {
            switch listTypes[cell.tag].type {
            case .NORMAL:
                let btn = UIButton(type: .system)
                btn.backgroundColor = .clear
                view.view.addSubview(btn)
                btn.anchor(top: cell.topAnchor, left: cell.leftAnchor, bottom: cell.bottomAnchor, right: cell.rightAnchor)
                btn.addAction {
                    print("Otro click, count", cell.tag)
                    self.presenter?.goToOption(indexN: cell.tag)
                }
            case .SWITCH(defaultIsOn: let defaultIsOn):
                let switchGenerated = UISwitch(frame: .zero)
                switchGenerated.setDimensions(height: 31, width: 51)
                switchGenerated.isOn = defaultIsOn
                switchGenerated.setOn(defaultIsOn, animated: true)
                view.view.addSubview(switchGenerated)
                switchGenerated.centerY(inView: cell)
                switchGenerated.anchor(right: cell.rightAnchor, paddingRight: 20)
                switchGenerated.addAction {
                    self.presenter?.clickSwitch(option: self.listTypes[cell.tag], switchC: switchGenerated, indexN: cell.tag)
                }
                let btn = UIButton(type: .system)
                btn.backgroundColor = .clear
                view.view.addSubview(btn)
                btn.setDimensions(height: 30, width: 30)
                btn.anchor(left: cell.leftAnchor, paddingLeft: 10)
                btn.centerY(inView: cell)
                btn.addAction {
                    print("Otro click, count", cell.tag)
                    self.presenter?.clickInformativeImage(option: self.listTypes[cell.tag], indexN: cell.tag)
                }
                startFunction(switchGenerated, cell.tag)
            case .INPUT:
                break
            }
        }
        
        
    }
    
    func generateOptions(view: ConfigurationsScreenView) -> UIView{
        let contentView = UIView()
        contentView.backgroundColor = .clear
        var topConstraint: NSLayoutYAxisAnchor?
        var count = 0
        for option in view.type.content {
            var cellView = UIView()
            switch option.type {
            case .NORMAL:
                cellView = generateNormalView(view: view, option: option, indexN: count)
            case .SWITCH:
                cellView = generateViewWithSwitch(view: view, option: option, indexN: count)
            case .INPUT:
                cellView = generateNormalView(view: view, option: option, indexN: count)
            }
            cellView.tag = count
            listCells.append(cellView)
            contentView.addSubview(cellView)
            cellView.anchor(left: contentView.leftAnchor, right: contentView.rightAnchor)
            if let topConstraintN = topConstraint {
                cellView.anchor(top: topConstraintN, paddingTop: 0)
            } else {
                cellView.anchor(top: contentView.topAnchor)
            }
            topConstraint = cellView.bottomAnchor
            count += 1
            if count == view.type.content.count {
                cellView.anchor(bottom: contentView.bottomAnchor)
            }
            listTags.append(option.title)
        }
        return contentView
    }
    
    func generateNormalView(view: ConfigurationsScreenView, option: ConfigurationsScreenOptions, indexN: Int) -> UIView{
        let cellView = UIView()
        cellView.isUserInteractionEnabled = true
        cellView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cellView.backgroundColor = .clear
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.setDimensions(height: 24, width: 24)
        img.image = UIImage(named: option.image, in: Bundle(for: ConfigurationsScreenInteractor.self), compatibleWith: nil)
        cellView.addSubview(img)
        img.anchor(left: cellView.leftAnchor, paddingLeft: 10)
        img.centerYToSuperview()
        let lblOption = GSVCLabel()
        lblOption.text = option.title
        lblOption.styleType = 6
        lblOption.textColorStyle = .GSVCText100
        cellView.addSubview(lblOption)
        lblOption.centerYToSuperview()
        lblOption.anchor(left: img.rightAnchor, paddingLeft: 10)
        let imgClick = UIImageView()
        imgClick.image = UIImage(named: option.image)
        imgClick.contentMode = .scaleAspectFill
        imgClick.setDimensions(height: 7, width: 14)
        cellView.addSubview(imgClick)
        imgClick.centerYToSuperview()
        imgClick.anchor(right: cellView.rightAnchor, paddingRight: 30)
        lblOption.anchor(right: imgClick.leftAnchor, paddingRight: 10)
        listTypes.append(option)
        return cellView
    }
    
    func generateViewWithSwitch(view: ConfigurationsScreenView, option: ConfigurationsScreenOptions, indexN: Int) -> UIView{
        let cellView = UIView()
        cellView.isUserInteractionEnabled = true
        cellView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        cellView.backgroundColor = .clear
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.setDimensions(height: 24, width: 24)
        img.image = UIImage(named: option.image, in: Bundle(for: ConfigurationsScreenInteractor.self), compatibleWith: nil)
        cellView.addSubview(img)
        img.anchor(left: cellView.leftAnchor, paddingLeft: 10)
        img.centerYToSuperview()
        let lblOption = GSVCLabel()
        lblOption.text = option.title
        lblOption.styleType = 6
        lblOption.textColorStyle = .GSVCText100
        cellView.addSubview(lblOption)
        lblOption.centerYToSuperview()
        lblOption.anchor(left: img.rightAnchor, paddingLeft: 10)
        listTypes.append(option)
        return cellView
    }
    
    
    
}




