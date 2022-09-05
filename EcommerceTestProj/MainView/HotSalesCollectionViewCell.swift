import UIKit

class HotSalesCollectionViewCell: UICollectionViewCell {
    
    static let identefier = "hotSalesCell"
    
    let img = UIImageView()
    let nameTitle = UILabel()
    let descriptionSubtitle = UILabel()
    let buyButton = UIButton()
    let newOrangeCircle = UIImageView()
    let newLabel = UILabel()
    var isNew:Bool? {
        didSet {
            self.updateUI()
        }
    }
    var imageURL:URL? {
        didSet{
            self.loadImage()
        }
    }
    
    enum ConstantValueUI:CGFloat {
        case nameFont = 24
        case imageCornerRadiues = 10
        case nameLeftAnchor = 30
        case newLabelFont = 7
        enum DescriptionLabel:CGFloat {
            case font = 10
            case topAnchor = 5
        }
        enum BuyButton:CGFloat {
            case topAnchor = 10
            case font = 11
        }
        enum newOrangeCircle:CGFloat {
            case topAnchor = 20
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = ConstantValueUI.imageCornerRadiues.rawValue
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        self.addSubview(img)
        
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameTitle.textColor = .white
        nameTitle.font = .boldSystemFont(ofSize: ConstantValueUI.nameFont.rawValue)
        self.addSubview(nameTitle)
        
        descriptionSubtitle.translatesAutoresizingMaskIntoConstraints = false
        descriptionSubtitle.textColor = .white
        descriptionSubtitle.font = .systemFont(ofSize: ConstantValueUI.DescriptionLabel.font.rawValue)
        self.addSubview(descriptionSubtitle)
    
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.backgroundColor = .white
        buyButton.setTitle("Buy now!", for: .normal)
        buyButton.setTitleColor(UIColor(named: ConstantName.tabBarColorName), for: .normal)
        buyButton.layer.cornerRadius = 8
        buyButton.titleLabel?.font = .boldSystemFont(ofSize: ConstantValueUI.BuyButton.font.rawValue)
        self.addSubview(buyButton)
        
        newOrangeCircle.translatesAutoresizingMaskIntoConstraints = false
        newOrangeCircle.image = UIImage(systemName: "circle.fill")
        newOrangeCircle.layer.transform = CATransform3DMakeScale(1.7, 1.7, 1.7)
        newOrangeCircle.tintColor = UIColor(named: ConstantName.orangeMainColor)
        
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        newLabel.textColor = .white
        newLabel.text = "New"
        newLabel.font = .systemFont(ofSize: ConstantValueUI.newLabelFont.rawValue)
        newOrangeCircle.addSubview(newLabel)
        
        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalToConstant: self.frame.width - 20),
            img.heightAnchor.constraint(equalToConstant: self.frame.height),
            img.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            img.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: ConstantValueUI.nameLeftAnchor.rawValue),
            descriptionSubtitle.leftAnchor.constraint(equalTo: nameTitle.leftAnchor),
            descriptionSubtitle.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: ConstantValueUI.DescriptionLabel.topAnchor.rawValue),
            buyButton.topAnchor.constraint(equalTo: descriptionSubtitle.bottomAnchor, constant: ConstantValueUI.BuyButton.topAnchor.rawValue),
            buyButton.leftAnchor.constraint(equalTo: nameTitle.leftAnchor),
            buyButton.widthAnchor.constraint(equalTo: descriptionSubtitle.widthAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        if isNew != nil {
            self.addSubview(newOrangeCircle)
            
            NSLayoutConstraint.activate([
            newOrangeCircle.leftAnchor.constraint(equalTo: nameTitle.leftAnchor),
            newOrangeCircle.topAnchor.constraint(equalTo: self.topAnchor, constant: ConstantValueUI.newOrangeCircle.topAnchor.rawValue),
            newLabel.centerXAnchor.constraint(equalTo: newOrangeCircle.centerXAnchor),
            newLabel.centerYAnchor.constraint(equalTo: newOrangeCircle.centerYAnchor)
            ])
        }
    }
    
    private func loadImage() {
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
    
    
}
