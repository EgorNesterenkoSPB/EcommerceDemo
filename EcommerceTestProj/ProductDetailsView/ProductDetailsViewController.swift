import UIKit
import iCarousel

class ProductDetailsViewController: UIViewController {
    
    var presenter:(ViewToPresenterProductDetailsProtocol & InteractorToPresenterProductDetailsProtocol)?
    let nameLabel = UILabel()
    let isFavoriteButton = UIButton()
    let addButton = UIButton()
    var productData:ProductDetails
    let topCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let descriptionalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var carouselView = iCarousel()
    
    enum ConstantValueUI:CGFloat {
        case topTitleLabelFont = 18
        case backButtonAndCartCornerRadius = 8
        case whiteBackgViewCornerRadius = 30
        case topTitleTopAnchor = 15
        case backButtonLeftAnchor = 20
        case backAndCartButtonWidth = 35
        case horizontalStackTopAnchor = 10
        case addButtonCornerRadius = 9
        enum NameLabel:CGFloat {
            case topAndLeftAnchor = 20
            case font = 25
        }
    }
    
    init(productData:ProductDetails) {
        self.productData = productData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    
    //MARK: - SetupUI
    private func setUpUI() {
        self.view.backgroundColor = .secondarySystemBackground
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        let topTitleLabel = UILabel()
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        topTitleLabel.text = "Product Details"
        topTitleLabel.textColor = UIColor(named: ConstantName.tabBarColorName)
        topTitleLabel.font = .systemFont(ofSize: ConstantValueUI.topTitleLabelFont.rawValue)
        scrollView.addSubview(topTitleLabel)
        
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: ConstantName.backImageName), for: .normal)
        backButton.backgroundColor = UIColor(named: ConstantName.tabBarColorName)
        backButton.layer.cornerRadius = ConstantValueUI.backButtonAndCartCornerRadius.rawValue
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        scrollView.addSubview(backButton)
        
        let cartButton = UIButton()
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        cartButton.backgroundColor = UIColor(named: ConstantName.orangeMainColor)
        cartButton.setImage(UIImage(systemName: ConstantName.cartImageName), for: .normal)
        cartButton.tintColor = .white
        cartButton.layer.cornerRadius = ConstantValueUI.backButtonAndCartCornerRadius.rawValue
        scrollView.addSubview(cartButton)
        
        let whiteBackgView = UIView()
        whiteBackgView.translatesAutoresizingMaskIntoConstraints = false
        whiteBackgView.backgroundColor = .white
        whiteBackgView.clipsToBounds = true
        whiteBackgView.layer.cornerRadius = ConstantValueUI.whiteBackgViewCornerRadius.rawValue
        whiteBackgView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        whiteBackgView.layer.masksToBounds = false
        whiteBackgView.layer.shadowColor = UIColor.black.cgColor
        whiteBackgView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        whiteBackgView.layer.shadowRadius = 5.0
        whiteBackgView.layer.shadowOpacity = 0.3
        scrollView.addSubview(whiteBackgView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .boldSystemFont(ofSize: ConstantValueUI.NameLabel.font.rawValue)
        nameLabel.textColor = UIColor(named: ConstantName.tabBarColorName)
        nameLabel.text = productData.title
        whiteBackgView.addSubview(nameLabel)
        
        isFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        isFavoriteButton.backgroundColor = UIColor(named: ConstantName.tabBarColorName)
        isFavoriteButton.setImage(productData.isFavorites ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        isFavoriteButton.tintColor = .white
        isFavoriteButton.layer.cornerRadius = ConstantValueUI.backButtonAndCartCornerRadius.rawValue
        whiteBackgView.addSubview(isFavoriteButton)
        
        let starsHorizontalStackView = UIStackView()
        starsHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        starsHorizontalStackView.alignment = .fill
        starsHorizontalStackView.axis = .horizontal
        starsHorizontalStackView.distribution = .equalSpacing
        starsHorizontalStackView.spacing = 5
        whiteBackgView.addSubview(starsHorizontalStackView)
        
        let topFlowLayout = UICollectionViewFlowLayout.init()
        topFlowLayout.scrollDirection = .horizontal
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        topCollectionView.setCollectionViewLayout(topFlowLayout, animated: false)
        topCollectionView.dataSource = self
        topCollectionView.delegate = self
        topCollectionView.backgroundColor = .clear
        topCollectionView.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: TopCollectionViewCell.identefier)
        topCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        whiteBackgView.addSubview(topCollectionView)
        
        let descriptionalFlowLayout = UICollectionViewFlowLayout.init()
        descriptionalFlowLayout.scrollDirection = .horizontal
        descriptionalCollectionView.setCollectionViewLayout(descriptionalFlowLayout, animated: false)
        descriptionalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionalCollectionView.dataSource = self
        descriptionalCollectionView.delegate = self
        descriptionalCollectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.identefier)
        descriptionalCollectionView.showsHorizontalScrollIndicator = false
        descriptionalCollectionView.isPagingEnabled = true
        descriptionalCollectionView.backgroundColor = .clear
        whiteBackgView.addSubview(descriptionalCollectionView)
        
        for index in 0...4 {
            let star = UIImageView()
            if Double(index + 1) < productData.rating {
                star.image = UIImage(systemName: "star.fill")
            }
            else if Double(index) + 0.5 == productData.rating {
                star.image = UIImage(systemName: "star.lefthalf.fill")
            }
            else {
                star.image = UIImage(systemName: "star")
            }
            star.tintColor = .orange
            starsHorizontalStackView.addArrangedSubview(star)
        }
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = UIColor(named: ConstantName.orangeMainColor)
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = ConstantValueUI.addButtonCornerRadius.rawValue
        addButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        addButton.setTitle("Add to Cart                         $\(productData.price)", for: .normal)
        whiteBackgView.addSubview(addButton)
        
        let backCarouselView = UIView()
        backCarouselView.translatesAutoresizingMaskIntoConstraints = false
        backCarouselView.backgroundColor = .clear
        scrollView.addSubview(backCarouselView)
        
        carouselView.type = .coverFlow
        carouselView.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 280)
        carouselView.dataSource = self
        carouselView.delegate = self
        carouselView.contentMode = .scaleAspectFill
        backCarouselView.addSubview(carouselView)

        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            whiteBackgView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            whiteBackgView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            whiteBackgView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            whiteBackgView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
            topTitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            topTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: ConstantValueUI.topTitleTopAnchor.rawValue),
            backButton.topAnchor.constraint(equalTo: topTitleLabel.topAnchor),
            backButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: ConstantValueUI.backButtonLeftAnchor.rawValue),
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width + ConstantValueUI.backAndCartButtonWidth.rawValue),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.width + ConstantValueUI.backAndCartButtonWidth.rawValue),
            cartButton.topAnchor.constraint(equalTo: topTitleLabel.topAnchor),
            cartButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -ConstantValueUI.backButtonLeftAnchor.rawValue),
            cartButton.widthAnchor.constraint(equalToConstant: cartButton.frame.width + ConstantValueUI.backAndCartButtonWidth.rawValue),
            cartButton.heightAnchor.constraint(equalToConstant: cartButton.frame.width + ConstantValueUI.backAndCartButtonWidth.rawValue),
            nameLabel.topAnchor.constraint(equalTo: whiteBackgView.topAnchor, constant: ConstantValueUI.NameLabel.topAndLeftAnchor.rawValue),
            nameLabel.leftAnchor.constraint(equalTo: whiteBackgView.leftAnchor, constant:ConstantValueUI.NameLabel.topAndLeftAnchor.rawValue),
            isFavoriteButton.widthAnchor.constraint(equalToConstant: isFavoriteButton.frame.width + ConstantValueUI.backAndCartButtonWidth.rawValue),
            isFavoriteButton.heightAnchor.constraint(equalToConstant: isFavoriteButton.frame.height + ConstantValueUI.backAndCartButtonWidth.rawValue),
            isFavoriteButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            isFavoriteButton.rightAnchor.constraint(equalTo: whiteBackgView.rightAnchor, constant: -ConstantValueUI.NameLabel.topAndLeftAnchor.rawValue),
            starsHorizontalStackView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            starsHorizontalStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: ConstantValueUI.horizontalStackTopAnchor.rawValue ),
            addButton.bottomAnchor.constraint(equalTo: whiteBackgView.bottomAnchor, constant: -20),
            addButton.rightAnchor.constraint(equalTo: whiteBackgView.rightAnchor, constant: -15),
            addButton.leftAnchor.constraint(equalTo: whiteBackgView.leftAnchor, constant: 15),
            addButton.heightAnchor.constraint(equalToConstant: 55),
            backCarouselView.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor,constant: 20),
            backCarouselView.bottomAnchor.constraint(equalTo: whiteBackgView.topAnchor),
            backCarouselView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            backCarouselView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            topCollectionView.topAnchor.constraint(equalTo: starsHorizontalStackView.bottomAnchor, constant: 10),
            topCollectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            topCollectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            topCollectionView.heightAnchor.constraint(equalToConstant: 50),
            descriptionalCollectionView.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor),
            descriptionalCollectionView.leftAnchor.constraint(equalTo: whiteBackgView.leftAnchor),
            descriptionalCollectionView.rightAnchor.constraint(equalTo: whiteBackgView.rightAnchor),
            descriptionalCollectionView.bottomAnchor.constraint(equalTo: addButton.topAnchor),
        ])
    }
    
    //MARK: - Buttons methods
    @objc private func backButtonTapped(_ sender:UIButton) {
        presenter?.userTapBackButton(navController: self.navigationController)
    }
    
}

//MARK: - PresenterToView methods
extension ProductDetailsViewController:PresenterToViewProductDetailsProtocol {

}

//MARK: - Collection methods
extension ProductDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topCollectionView:
            return presenter?.numberOfRowsAtTopSection() ?? 0
        case descriptionalCollectionView:
            return presenter?.numberOfRowsAtTopSection() ?? 0
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case topCollectionView:
            return presenter?.setTopCell(collectionView: collectionView, forRowAt: indexPath) ?? TopCollectionViewCell()
        case descriptionalCollectionView:
            return presenter?.setShopCell(collectionView: collectionView, forRowAt: indexPath, productDetails:productData) ?? UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case topCollectionView:
            return presenter?.topCellSize(width: (self.view.frame.width / 3) - 10) ?? CGSize()
        case descriptionalCollectionView:
            return presenter?.shopCellSize(width: collectionView.frame.width, height: collectionView.frame.height) ?? CGSize()
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case topCollectionView:
            return presenter?.topUIEdgeInsets() ?? UIEdgeInsets()
        case descriptionalCollectionView:
            return presenter?.shopUIEdgeInsets() ?? UIEdgeInsets()
        default:
            return UIEdgeInsets()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case topCollectionView:
            presenter?.didSelectTopItemAt(topCollectionView: topCollectionView, indexPath: indexPath, descriptionalCollectionView: descriptionalCollectionView)
        default:
            return
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / (view.frame.width)
        let indexPath = IndexPath(item: Int(index), section: 0)
        topCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        presenter?.didSelectTopItemAt(topCollectionView: topCollectionView, indexPath: indexPath, descriptionalCollectionView: descriptionalCollectionView)
    }
}

//MARK: - iCarousel methods
extension ProductDetailsViewController:iCarouselDelegate,iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        productData.images.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 200, height: 280))
        view.backgroundColor = .clear
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        if let url = URL(string: productData.images[index]) {
            DispatchQueue.global(qos: .userInitiated).async {
                NetworkManager().fetchData(url: url, completion: { response in
                    switch response.result{
                    case .success(let responseData):
                        guard let data = responseData else {return}
                        imageView.image = UIImage(data: data)
                    case .failure(_):
                        imageView.image = UIImage(systemName: ConstantName.defaultImageName)
                    }
                })
            }
        }
        NSLayoutConstraint.activate([
        imageView.widthAnchor.constraint(equalToConstant:UIScreen.main.bounds.width - 200),
        imageView.heightAnchor.constraint(equalToConstant: 280),
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        return view
    }
    
    
}
