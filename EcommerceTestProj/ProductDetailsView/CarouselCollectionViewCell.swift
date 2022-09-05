import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    static let identefier = "carouselCell"
    let img = UIImageView()
    var imageURL:URL? {
        didSet{
            self.loadImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.backgroundColor = .clear
        
        
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        self.addSubview(img)
        
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: self.topAnchor),
            img.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            img.rightAnchor.constraint(equalTo: self.rightAnchor),
            img.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage() {
        if let url = imageURL {
            DispatchQueue.global(qos: .userInitiated).async {
                NetworkManager().fetchData(url: url, completion: { [weak self] response in
                    guard let self = self else {return}
                    switch response.result{
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
