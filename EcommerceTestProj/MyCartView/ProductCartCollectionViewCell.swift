import UIKit

class ProductCartCollectionViewCell: UICollectionViewCell {

    static let identefier = "productCartCell"
    let productImageView = UIImageView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let countProductLabel = UILabel()
    var imageURL:URL? {
        didSet {
            self.loadImage()
        }
    }
    enum ConstantValueUI:CGFloat {
        case productImageLeftAnchor = 10
        case productImageCornerRadius = 7
        case nameAndPriceLabelFont = 20
        case productImageWidthAndHeight = 100
        case verticalStackRightAnchor = -15
        case verticalStackWidth = 23
        case verticalStackHeight = 70
        case trashButtonRightAnchor = -10
        enum CountProductLabel:CGFloat {
            case font = 20
        }
        enum NameLabel:CGFloat {
            case leftAnchor = 10
            case rightAnchor = -10
        }
        enum PriceLabel:CGFloat {
            case topAnchor = 10
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.cornerRadius = ConstantValueUI.productImageCornerRadius.rawValue
        productImageView.clipsToBounds = true
        self.addSubview(productImageView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 2
        nameLabel.font = .boldSystemFont(ofSize: ConstantValueUI.nameAndPriceLabelFont.rawValue)
        self.addSubview(nameLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = .orange
        priceLabel.font = .boldSystemFont(ofSize: ConstantValueUI.nameAndPriceLabelFont.rawValue)
        self.addSubview(priceLabel)
        
        let verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 2
        verticalStackView.distribution = .equalSpacing
        verticalStackView.addBackground(color: .darkGray)
        self.addSubview(verticalStackView)
        
        let minusButton = UIButton()
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minusButton.backgroundColor = .clear
        minusButton.tintColor = .white
        minusButton.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        verticalStackView.addArrangedSubview(minusButton)
        
        countProductLabel.translatesAutoresizingMaskIntoConstraints = false
        countProductLabel.textColor = .white
        countProductLabel.font = .boldSystemFont(ofSize: ConstantValueUI.CountProductLabel.font.rawValue)
        verticalStackView.addArrangedSubview(countProductLabel)
        
        let plusButton = UIButton()
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.backgroundColor = .clear
        plusButton.tintColor = .white
        plusButton.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        verticalStackView.addArrangedSubview(plusButton)
        
        let trashButton = UIButton()
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        trashButton.setImage(UIImage(systemName: "trash"), for: .normal)
        trashButton.tintColor = .darkGray
        self.addSubview(trashButton)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: self.topAnchor),
            productImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: ConstantValueUI.productImageLeftAnchor.rawValue),
            productImageView.widthAnchor.constraint(equalToConstant: ConstantValueUI.productImageWidthAndHeight.rawValue),
            productImageView.heightAnchor.constraint(equalToConstant: ConstantValueUI.productImageWidthAndHeight.rawValue),
            nameLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor,constant: ConstantValueUI.NameLabel.leftAnchor.rawValue),
            nameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            nameLabel.rightAnchor.constraint(equalTo: verticalStackView.leftAnchor, constant: ConstantValueUI.NameLabel.rightAnchor.rawValue),
            priceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: ConstantValueUI.PriceLabel.topAnchor.rawValue),
            verticalStackView.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: trashButton.leftAnchor, constant: ConstantValueUI.verticalStackRightAnchor.rawValue),
            verticalStackView.widthAnchor.constraint(equalToConstant: ConstantValueUI.verticalStackWidth.rawValue),
            verticalStackView.heightAnchor.constraint(equalToConstant: ConstantValueUI.verticalStackHeight.rawValue),
            trashButton.centerYAnchor.constraint(equalTo: verticalStackView.centerYAnchor),
            trashButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: ConstantValueUI.trashButtonRightAnchor.rawValue)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage() {
        if let url = imageURL {
            DispatchQueue.global(qos: .userInitiated).async {
                NetworkManager().fetchData(url: url, completion: { [weak self] reponse in
                    guard let self = self else {return}
                    switch reponse.result {
                    case .success(let responseData):
                        guard let data = responseData else {return}
                        self.productImageView.image = UIImage(data: data)
                    case .failure(_):
                        self.productImageView.image = UIImage(systemName: ConstantName.defaultImageName)
                    }
                })
            }
        }
    }
    
}
