import UIKit

class TopCollectionViewCell: UICollectionViewCell {

    static let identefier = "topCollectionViewCell"
    let nameLabel = UILabel()
    let horizontalIndicator = UIView()
    override var isSelected: Bool {
        didSet{
            nameLabel.textColor = isSelected ? UIColor(named: ConstantName.tabBarColorName) : UIColor.gray
            nameLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 18) : UIFont.systemFont(ofSize: ConstantValueUI.nameLabelFont.rawValue)
            horizontalIndicator.backgroundColor = isSelected ? UIColor(named: ConstantName.orangeMainColor) : .clear
        }
    }
    
    enum ConstantValueUI:CGFloat {
        case nameLabelFont = 18
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = .clear
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .gray
        nameLabel.font = .systemFont(ofSize: ConstantValueUI.nameLabelFont.rawValue)
        self.addSubview(nameLabel)
        
        horizontalIndicator.translatesAutoresizingMaskIntoConstraints = false
        horizontalIndicator.backgroundColor = .clear
        horizontalIndicator.layer.cornerRadius = 4
        self.addSubview(horizontalIndicator)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            horizontalIndicator.heightAnchor.constraint(equalToConstant: 3.5),
            horizontalIndicator.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            horizontalIndicator.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20),
            horizontalIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
