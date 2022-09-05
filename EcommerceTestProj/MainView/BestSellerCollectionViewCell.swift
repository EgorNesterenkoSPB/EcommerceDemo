import UIKit

class BestSellerCollectionViewCell: UICollectionViewCell {
    
    static let identefier = "bestSellerCell"
    var img = UIImageView()
    var name = UILabel()
    var priceWithOutDiscondLabel = UILabel()
    var priceWithDiscondLabel = UILabel()
    var cirlceImageButton = UIButton()
    var heartImage = UIImageView()
    var imageURL:URL? {
        didSet {
            self.updateUI()
        }
    }
    var isTapped:Bool = false
    enum ConstantValueUI:CGFloat {
        case priceWithDiscondFont = 20
        case priceWithOutDiscondFont = 10
        
        enum NameLabel:CGFloat {
            case font = 10
            case bottomAnchor = -10
        }
        enum CircleImageButton:CGFloat {
            case topAnchor = 10
            case rightAnchor = -10
        }
        enum PriceWithDiscond:CGFloat {
            case leftAnchor = 20
        }
        enum PriceWithOutDiscond:CGFloat {
            case leftAnchor = 10
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        self.addSubview(img)
        
        priceWithDiscondLabel.translatesAutoresizingMaskIntoConstraints = false
        priceWithDiscondLabel.textColor = UIColor(named: ConstantName.tabBarColorName)
        priceWithDiscondLabel.font = .boldSystemFont(ofSize: ConstantValueUI.priceWithDiscondFont.rawValue)
        self.addSubview(priceWithDiscondLabel)
        
        priceWithOutDiscondLabel.translatesAutoresizingMaskIntoConstraints = false
        priceWithOutDiscondLabel.textColor = .gray
        priceWithOutDiscondLabel.font = .systemFont(ofSize: ConstantValueUI.priceWithOutDiscondFont.rawValue)
        self.addSubview(priceWithOutDiscondLabel)
    
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        heartImage.image = UIImage(systemName: "heart")
        heartImage.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        heartImage.tintColor = UIColor(named: ConstantName.orangeMainColor)
        
        cirlceImageButton.translatesAutoresizingMaskIntoConstraints = false
        cirlceImageButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        cirlceImageButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        cirlceImageButton.tintColor = UIColor(named: ConstantName.favoriteButtonBackColor)
        cirlceImageButton.layer.shadowColor = UIColor.black.cgColor
        cirlceImageButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        cirlceImageButton.layer.shadowRadius = 2.0
        cirlceImageButton.layer.shadowOpacity = 0.5
        cirlceImageButton.layer.cornerRadius = cirlceImageButton.frame.width / 2
        cirlceImageButton.layer.masksToBounds = false
        cirlceImageButton.addTarget(self, action: #selector(isFavoriteButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(cirlceImageButton)
        cirlceImageButton.addSubview(heartImage)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor(named: ConstantName.tabBarColorName)
        name.font = .systemFont(ofSize: ConstantValueUI.NameLabel.font.rawValue)
        self.addSubview(name)
        
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            img.topAnchor.constraint(equalTo: self.topAnchor),
            img.leftAnchor.constraint(equalTo: self.leftAnchor),
            img.rightAnchor.constraint(equalTo: self.rightAnchor),
            img.heightAnchor.constraint(equalToConstant: (self.frame.height * 2) / 3),
            cirlceImageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: ConstantValueUI.CircleImageButton.topAnchor.rawValue),
            cirlceImageButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: ConstantValueUI.CircleImageButton.rightAnchor.rawValue),
            cirlceImageButton.centerXAnchor.constraint(equalTo: cirlceImageButton.centerXAnchor),
            cirlceImageButton.centerYAnchor.constraint(equalTo: cirlceImageButton.centerYAnchor),
            priceWithDiscondLabel.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 0),
            priceWithDiscondLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: ConstantValueUI.PriceWithDiscond.leftAnchor.rawValue),
            priceWithOutDiscondLabel.centerYAnchor.constraint(equalTo: priceWithDiscondLabel.centerYAnchor),
            priceWithOutDiscondLabel.leftAnchor.constraint(equalTo: priceWithDiscondLabel.rightAnchor, constant: ConstantValueUI.PriceWithOutDiscond.leftAnchor.rawValue),
            name.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ConstantValueUI.NameLabel.bottomAnchor.rawValue),
            name.leftAnchor.constraint(equalTo: priceWithDiscondLabel.leftAnchor),
            name.topAnchor.constraint(equalTo: priceWithDiscondLabel.bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        if let url = imageURL {
            DispatchQueue.global(qos: .userInitiated).async {
                NetworkManager().fetchData(url: url, completion: { [weak self] response in
                    guard let self = self else {return}
                    switch response.result {
                    case .success(let responseData):
                        guard let data = responseData else {return}
                        self.img.image = UIImage(data: data)
                    case .failure(_):
                        self.img.image = UIImage(systemName: ConstantName.defaultImageName)
                    }
                })
            }
        }
    }

    @objc private func isFavoriteButtonTapped(_ sender:UIButton) {
        self.updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        if isTapped {
            self.heartImage.image = UIImage(systemName: "heart")
            self.isTapped = false
        }
        else {
            self.heartImage.image = UIImage(systemName: "heart.fill")
            self.isTapped = true
        }
    }
    
}
