import UIKit

class ShopCollectionViewCell: UICollectionViewCell {

    static let identefier = "shopCollectionViewCell"
    let cpuSublabel = UILabel()
    let cameraSublabel = UILabel()
    let sdSublabel = UILabel()
    let ssdSublabel = UILabel()
    let firstColorCircleButton = UIButton()
    let secondColorCircleButton = UIButton()
    let firstCapacityButton = UIButton()
    let secondCapacityButton = UIButton()
    let checkmarkIV = UIImageView()
    
    enum ConstantValueUI:CGFloat {
        case WidthAndHeightImage = 30
        case cpuImageViewTopAnchor = 10
        case capacityButtonCornerRadius = 8
        case scaleCircleImage = 2.3
        case imagesSublabelFont = 11
        enum Sublabel:CGFloat {
            case font = 15
        }
        enum SelectLabel:CGFloat {
            case font = 18
            case topAndLeftAnchor = 10
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        let cpuImageView = UIImageView()
        cpuImageView.translatesAutoresizingMaskIntoConstraints = false
        cpuImageView.image = UIImage(named: ConstantName.cpuImageName)
        cpuImageView.contentMode = .scaleAspectFill
        self.addSubview(cpuImageView)
        
        let cameraImageView = UIImageView()
        cameraImageView.translatesAutoresizingMaskIntoConstraints = false
        cameraImageView.image = UIImage(systemName: "camera")
        cameraImageView.tintColor = .lightGray
        self.addSubview(cameraImageView)
        
        let ssdImageView = UIImageView()
        ssdImageView.translatesAutoresizingMaskIntoConstraints = false
        ssdImageView.image = UIImage(named: ConstantName.ssdImageName)
        ssdImageView.contentMode = .scaleAspectFill
        self.addSubview(ssdImageView)
        
        let sdImageView = UIImageView()
        sdImageView.translatesAutoresizingMaskIntoConstraints = false
        sdImageView.image = UIImage(named: ConstantName.sdImageName)
        sdImageView.contentMode = .scaleAspectFill
        self.addSubview(sdImageView)
        
        
        self.setupSublabel(sublabel: cpuSublabel)
        self.setupSublabel(sublabel: cameraSublabel)
        self.setupSublabel(sublabel: ssdSublabel)
        self.setupSublabel(sublabel: sdSublabel)
        
        let selectLabel = UILabel()
        selectLabel.translatesAutoresizingMaskIntoConstraints = false
        selectLabel.text = "Select color and capacity"
        selectLabel.textColor = UIColor(named: ConstantName.tabBarColorName)
        selectLabel.font = .boldSystemFont(ofSize: ConstantValueUI.SelectLabel.font.rawValue)
        self.addSubview(selectLabel)
        
        firstColorCircleButton.translatesAutoresizingMaskIntoConstraints = false
        firstColorCircleButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        firstColorCircleButton.imageView?.layer.transform = CATransform3DMakeScale(ConstantValueUI.scaleCircleImage.rawValue, ConstantValueUI.scaleCircleImage.rawValue, ConstantValueUI.scaleCircleImage.rawValue)
        firstColorCircleButton.backgroundColor = .clear
        firstColorCircleButton.addTarget(self, action: #selector(circleButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(firstColorCircleButton)
        
        secondColorCircleButton.translatesAutoresizingMaskIntoConstraints = false
        secondColorCircleButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        secondColorCircleButton.imageView?.layer.transform = CATransform3DMakeScale(ConstantValueUI.scaleCircleImage.rawValue, ConstantValueUI.scaleCircleImage.rawValue, ConstantValueUI.scaleCircleImage.rawValue)
        secondColorCircleButton.backgroundColor = .clear
        secondColorCircleButton.addTarget(self, action: #selector(circleButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(secondColorCircleButton)
        
        firstCapacityButton.translatesAutoresizingMaskIntoConstraints = false
        firstCapacityButton.backgroundColor = .clear
        firstCapacityButton.setTitleColor(.gray, for: .normal)
        firstCapacityButton.titleLabel?.font = .boldSystemFont(ofSize: ConstantValueUI.Sublabel.font.rawValue)
        firstCapacityButton.layer.cornerRadius = ConstantValueUI.capacityButtonCornerRadius.rawValue
        firstCapacityButton.addTarget(self, action: #selector(capacityButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(firstCapacityButton)
        
        secondCapacityButton.translatesAutoresizingMaskIntoConstraints = false
        secondCapacityButton.backgroundColor = .clear
        secondCapacityButton.setTitleColor(.gray, for: .normal)
        secondCapacityButton.titleLabel?.font = .boldSystemFont(ofSize: ConstantValueUI.Sublabel.font.rawValue)
        secondCapacityButton.layer.cornerRadius = ConstantValueUI.capacityButtonCornerRadius.rawValue
        secondCapacityButton.addTarget(self, action: #selector(capacityButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(secondCapacityButton)
        
        
        NSLayoutConstraint.activate([
            cpuImageView.heightAnchor.constraint(equalToConstant: ConstantValueUI.WidthAndHeightImage.rawValue),
            cpuImageView.widthAnchor.constraint(equalToConstant: ConstantValueUI.WidthAndHeightImage.rawValue),
            sdImageView.widthAnchor.constraint(equalToConstant: ConstantValueUI.WidthAndHeightImage.rawValue),
            sdImageView.heightAnchor.constraint(equalToConstant: ConstantValueUI.WidthAndHeightImage.rawValue),
            ssdImageView.widthAnchor.constraint(equalToConstant: ConstantValueUI.WidthAndHeightImage.rawValue),
            ssdImageView.heightAnchor.constraint(equalToConstant: ConstantValueUI.WidthAndHeightImage.rawValue),
            cameraImageView.widthAnchor.constraint(equalToConstant: ConstantValueUI.WidthAndHeightImage.rawValue),
            cameraImageView.heightAnchor.constraint(equalToConstant: ConstantValueUI.WidthAndHeightImage.rawValue),
            cpuImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: ConstantValueUI.cpuImageViewTopAnchor.rawValue),
            cpuImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: ((self.frame.width / 4) - ConstantValueUI.WidthAndHeightImage.rawValue) / 2),
            cameraImageView.topAnchor.constraint(equalTo: cpuImageView.topAnchor),
            cameraImageView.leftAnchor.constraint(equalTo: cpuImageView.rightAnchor, constant: ((self.frame.width / 4) - ConstantValueUI.WidthAndHeightImage.rawValue) ),
            ssdImageView.topAnchor.constraint(equalTo: cpuImageView.topAnchor),
            ssdImageView.leftAnchor.constraint(equalTo: cameraImageView.rightAnchor, constant: ((self.frame.width / 4) - ConstantValueUI.WidthAndHeightImage.rawValue)),
            sdImageView.topAnchor.constraint(equalTo: cpuImageView.topAnchor),
            sdImageView.leftAnchor.constraint(equalTo: ssdImageView.rightAnchor, constant: ((self.frame.width / 4) - ConstantValueUI.WidthAndHeightImage.rawValue)),
            cpuSublabel.centerXAnchor.constraint(equalTo: cpuImageView.centerXAnchor),
            cpuSublabel.topAnchor.constraint(equalTo: cpuImageView.bottomAnchor,constant: 10),
            cameraSublabel.topAnchor.constraint(equalTo: cpuSublabel.topAnchor),
            cameraSublabel.centerXAnchor.constraint(equalTo: cameraImageView.centerXAnchor),
            ssdSublabel.centerXAnchor.constraint(equalTo: ssdImageView.centerXAnchor),
            ssdSublabel.topAnchor.constraint(equalTo: cpuSublabel.topAnchor),
            sdSublabel.centerXAnchor.constraint(equalTo: sdImageView.centerXAnchor),
            sdSublabel.topAnchor.constraint(equalTo: cpuSublabel.topAnchor),
            selectLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            selectLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: ConstantValueUI.SelectLabel.topAndLeftAnchor.rawValue),
            firstColorCircleButton.topAnchor.constraint(equalTo: selectLabel.bottomAnchor, constant: 20),
            firstColorCircleButton.leftAnchor.constraint(equalTo: selectLabel.leftAnchor,constant: 10),
            secondColorCircleButton.topAnchor.constraint(equalTo: firstColorCircleButton.topAnchor),
            secondColorCircleButton.leftAnchor.constraint(equalTo: firstColorCircleButton.rightAnchor, constant: 40),
            firstCapacityButton.centerYAnchor.constraint(equalTo: firstColorCircleButton.centerYAnchor),
            firstCapacityButton.rightAnchor.constraint(equalTo: secondCapacityButton.leftAnchor, constant: -20),
            firstCapacityButton.widthAnchor.constraint(equalToConstant: firstCapacityButton.frame.width + 80),
            firstCapacityButton.heightAnchor.constraint(equalToConstant: firstCapacityButton.frame.height + 30),
            secondCapacityButton.centerYAnchor.constraint(equalTo: firstCapacityButton.centerYAnchor),
            secondCapacityButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50),
            secondCapacityButton.widthAnchor.constraint(equalTo: firstCapacityButton.widthAnchor),
            secondCapacityButton.heightAnchor.constraint(equalTo: firstCapacityButton.heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSublabel(sublabel:UILabel) {
        sublabel.translatesAutoresizingMaskIntoConstraints = false
        sublabel.textColor = .lightGray
        sublabel.font = .systemFont(ofSize: ConstantValueUI.imagesSublabelFont.rawValue)
        self.addSubview(sublabel)
    }
    
    @objc private func capacityButtonTapped(_ sender:UIButton) {
        if sender == firstCapacityButton {
            firstCapacityButton.backgroundColor = UIColor(named: ConstantName.orangeMainColor)
            firstCapacityButton.setTitleColor(.white, for: .normal)
            secondCapacityButton.backgroundColor = .clear
            secondCapacityButton.setTitleColor(.gray, for: .normal)
        }
        else {
            firstCapacityButton.backgroundColor = .clear
            firstCapacityButton.setTitleColor(.gray, for: .normal)
            secondCapacityButton.backgroundColor = UIColor(named: ConstantName.orangeMainColor)
            secondCapacityButton.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc private func circleButtonTapped(_ sender: UIButton) {
        
        checkmarkIV.image = UIImage(systemName: "checkmark")
        checkmarkIV.translatesAutoresizingMaskIntoConstraints = false
        checkmarkIV.tintColor = .white
        
        if sender == firstColorCircleButton {
            secondColorCircleButton.subviews.forEach({if $0 == checkmarkIV {
                $0.removeFromSuperview()
                }})
            firstColorCircleButton.addSubview(checkmarkIV)

        }
        else {
            firstColorCircleButton.subviews.forEach({ if $0 == checkmarkIV {
                checkmarkIV.removeFromSuperview()
                }})
            secondColorCircleButton.addSubview(checkmarkIV)
        }
    }
    
    
}
