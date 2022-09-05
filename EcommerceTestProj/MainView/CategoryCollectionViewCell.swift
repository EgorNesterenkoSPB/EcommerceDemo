import UIKit


class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identefier = "CategoryCell"
    let circleImage = UIImageView()
    let img = UIImageView()
    let titleName = UILabel()

    override var isSelected: Bool {
        didSet {
            circleImage.tintColor = isSelected ? UIColor(named: ConstantName.orangeMainColor) : .white
            img.tintColor = isSelected ? .white : .lightGray
            titleName.textColor = isSelected ? UIColor(named: ConstantName.orangeMainColor) : UIColor(named: ConstantName.tabBarColorName)
        }
    }
    
    enum ConstantValueUI:CGFloat {
        case titleFont = 9
        case circleImageWidthHeight = 70
        case titleTopAnchor = 3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        circleImage.image = UIImage(systemName: "circle.fill")
        circleImage.tintColor = .white
        self.addSubview(circleImage)
        
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .lightGray
        img.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.3)
        circleImage.addSubview(img)
        
        titleName.translatesAutoresizingMaskIntoConstraints = false
        titleName.textColor = UIColor(named: ConstantName.tabBarColorName)
        titleName.font = .systemFont(ofSize: ConstantValueUI.titleFont.rawValue)
        self.addSubview(titleName)
        
        NSLayoutConstraint.activate([
            circleImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            circleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            circleImage.widthAnchor.constraint(equalToConstant: ConstantValueUI.circleImageWidthHeight.rawValue),
            circleImage.heightAnchor.constraint(equalToConstant: ConstantValueUI.circleImageWidthHeight.rawValue),
            img.centerXAnchor.constraint(equalTo: circleImage.centerXAnchor),
            img.centerYAnchor.constraint(equalTo: circleImage.centerYAnchor),
            titleName.topAnchor.constraint(equalTo: circleImage.bottomAnchor,constant: ConstantValueUI.titleTopAnchor.rawValue),
            titleName.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
