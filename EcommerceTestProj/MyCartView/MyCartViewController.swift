import UIKit

class MyCartViewController: UIViewController {
    
    let contentView = UIView()
    let totalPriceLabel = UILabel()
    let deliveryPriceLabel = UILabel()
    var presenter:(ViewToPresenterMyCartProtocol & InteractorToPresenterMyCartProtocol)?
    let productCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var delegate:MyCartViewControllerProtocol?

    enum ConstantValueUI:CGFloat {
        case contentViewCornerRaius = 30
        case comeBackButtonCornerRadius = 8
        case addressLabelFont = 15
        case myCartLabelFont = 31
        case checkoutButtonFont = 21
        case comebackButtonTopAndLeftAnchor = 20
        case checkoutButtonCornerRadius = 9
        case bottomDidviderOpacity = 0.5
        case topDividerOpacity = 0.3
        case addressButtonRightAnchor = -20
        case addAddressLabelRightAnchor = -10
        case myCartLabelTopAnchor = 35
        case priceLabelFont = 16
        case totalPriceLabelRightAnchor = -11
        case productCollectViewTopAnchor = 50
        enum CheckoutButton:CGFloat {
            case bottomAndRightAnchor = -20
            case leftAnchor = 20
        }
        enum BottomDivider:CGFloat {
            case bottomAnchor = -20
        }
        enum DeliveryLabel:CGFloat {
            case leftAnchor = 10
            case bottomAchor = -30
        }
        enum TotalLabel:CGFloat {
            case bottomAnchor = -20
            case font = 15
        }
        enum TopDivider:CGFloat {
            case bottomAnchor = -20
        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    
    //MARK: Setup View
    private func setupView() {
        self.view.backgroundColor = .white
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(named: ConstantName.tabBarColorName)
        contentView.layer.cornerRadius = ConstantValueUI.contentViewCornerRaius.rawValue
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        self.view.addSubview(contentView)
        
        let comeBackButton = UIButton()
        comeBackButton.backgroundColor = UIColor(named: ConstantName.tabBarColorName)
        comeBackButton.setImage(UIImage(systemName: ConstantName.backImageName), for: .normal)
        comeBackButton.tintColor = .white
        comeBackButton.translatesAutoresizingMaskIntoConstraints = false
        comeBackButton.layer.cornerRadius = ConstantValueUI.comeBackButtonCornerRadius.rawValue
        comeBackButton.addTarget(self, action: #selector(comeBackButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(comeBackButton)
        
        let addressButton = UIButton()
        addressButton.translatesAutoresizingMaskIntoConstraints = false
        addressButton.backgroundColor = UIColor(named: ConstantName.orangeMainColor)
        addressButton.setImage(UIImage(systemName: "mappin"), for: .normal)
        addressButton.tintColor = .white
        addressButton.layer.cornerRadius = ConstantValueUI.comeBackButtonCornerRadius.rawValue
        self.view.addSubview(addressButton)
        
        let addAddressLabel = UILabel()
        addAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        addAddressLabel.text = "Add address"
        addAddressLabel.textColor = UIColor(named: ConstantName.tabBarColorName)
        addAddressLabel.font = .systemFont(ofSize: ConstantValueUI.addressLabelFont.rawValue)
        self.view.addSubview(addAddressLabel)
        
        let myCartLabel = UILabel()
        myCartLabel.translatesAutoresizingMaskIntoConstraints = false
        myCartLabel.text = "My Cart"
        myCartLabel.textColor = UIColor(named: ConstantName.tabBarColorName)
        myCartLabel.font = .boldSystemFont(ofSize: ConstantValueUI.myCartLabelFont.rawValue)
        self.view.addSubview(myCartLabel)
        
        let checkoutButton = UIButton()
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.layer.cornerRadius = ConstantValueUI.checkoutButtonCornerRadius.rawValue
        checkoutButton.backgroundColor = UIColor(named: ConstantName.orangeMainColor)
        checkoutButton.setTitle("Checkout", for: .normal)
        checkoutButton.titleLabel?.textColor = .white
        checkoutButton.titleLabel?.font = .boldSystemFont(ofSize: ConstantValueUI.checkoutButtonFont.rawValue)
        contentView.addSubview(checkoutButton)
        
        let bottomDividerView = UIView()
        bottomDividerView.translatesAutoresizingMaskIntoConstraints = false
        bottomDividerView.backgroundColor = .darkGray
        bottomDividerView.layer.opacity = Float(ConstantValueUI.bottomDidviderOpacity.rawValue)
        contentView.addSubview(bottomDividerView)
        
        let totalLabel = UILabel()
        self.setupBottomLabel(label: totalLabel, text: "Total")
        
        let deliveryLabel = UILabel()
        self.setupBottomLabel(label: deliveryLabel, text: "Delivery")
        
        let topDividerView = UIView()
        topDividerView.translatesAutoresizingMaskIntoConstraints = false
        topDividerView.backgroundColor = .lightGray
        topDividerView.layer.opacity = Float(ConstantValueUI.topDividerOpacity.rawValue)
        contentView.addSubview(topDividerView)
        
        self.setupBottomPriceLabel(label: totalPriceLabel)
        self.setupBottomPriceLabel(label: deliveryPriceLabel)
        
        let productFlowLayout = UICollectionViewFlowLayout.init()
        productFlowLayout.scrollDirection = .vertical
        
        productCollectionView.setCollectionViewLayout(productFlowLayout, animated: false)
        productCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productCollectionView.backgroundColor = .clear
        productCollectionView.register(ProductCartCollectionViewCell.self, forCellWithReuseIdentifier: ProductCartCollectionViewCell.identefier)
        productCollectionView.showsVerticalScrollIndicator = false
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        contentView.addSubview(productCollectionView)
        
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            contentView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height * 2) / 3),
            comeBackButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: ConstantValueUI.comebackButtonTopAndLeftAnchor.rawValue),
            comeBackButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: ConstantValueUI.comebackButtonTopAndLeftAnchor.rawValue),
            comeBackButton.widthAnchor.constraint(equalToConstant: comeBackButton.frame.width + 40),
            comeBackButton.heightAnchor.constraint(equalToConstant: comeBackButton.frame.width + 40),
            addressButton.centerYAnchor.constraint(equalTo: comeBackButton.centerYAnchor),
            addressButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: ConstantValueUI.addressButtonRightAnchor.rawValue),
            addressButton.widthAnchor.constraint(equalTo: comeBackButton.widthAnchor),
            addressButton.heightAnchor.constraint(equalTo: comeBackButton.heightAnchor),
            addAddressLabel.centerYAnchor.constraint(equalTo: addressButton.centerYAnchor),
            addAddressLabel.rightAnchor.constraint(equalTo: addressButton.leftAnchor, constant: ConstantValueUI.addAddressLabelRightAnchor.rawValue),
            myCartLabel.leftAnchor.constraint(equalTo: comeBackButton.leftAnchor),
            myCartLabel.topAnchor.constraint(equalTo: comeBackButton.bottomAnchor,constant: ConstantValueUI.myCartLabelTopAnchor.rawValue),
            checkoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ConstantValueUI.CheckoutButton.bottomAndRightAnchor.rawValue),
            checkoutButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: ConstantValueUI.CheckoutButton.bottomAndRightAnchor.rawValue),
            checkoutButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: ConstantValueUI.CheckoutButton.leftAnchor.rawValue),
            checkoutButton.heightAnchor.constraint(equalToConstant: checkoutButton.frame.height + 50),
            bottomDividerView.heightAnchor.constraint(equalToConstant: 1),
            bottomDividerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bottomDividerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bottomDividerView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: ConstantValueUI.BottomDivider.bottomAnchor.rawValue),
            deliveryLabel.leftAnchor.constraint(equalTo: checkoutButton.leftAnchor,constant: ConstantValueUI.DeliveryLabel.leftAnchor.rawValue),
            deliveryLabel.bottomAnchor.constraint(equalTo: bottomDividerView.topAnchor, constant: ConstantValueUI.DeliveryLabel.bottomAchor.rawValue),
            totalLabel.leftAnchor.constraint(equalTo: deliveryLabel.leftAnchor),
            totalLabel.bottomAnchor.constraint(equalTo: deliveryLabel.topAnchor, constant: ConstantValueUI.TotalLabel.bottomAnchor.rawValue),
            topDividerView.heightAnchor.constraint(equalToConstant: 1.5),
            topDividerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            topDividerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            topDividerView.bottomAnchor.constraint(equalTo: totalLabel.topAnchor, constant: ConstantValueUI.TopDivider.bottomAnchor.rawValue),
            totalPriceLabel.centerYAnchor.constraint(equalTo: totalLabel.centerYAnchor),
            totalPriceLabel.rightAnchor.constraint(equalTo: checkoutButton.rightAnchor, constant: ConstantValueUI.totalPriceLabelRightAnchor.rawValue),
            deliveryPriceLabel.centerYAnchor.constraint(equalTo: deliveryLabel.centerYAnchor),
            deliveryPriceLabel.leftAnchor.constraint(equalTo: totalPriceLabel.leftAnchor),
            productCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            productCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            productCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstantValueUI.productCollectViewTopAnchor.rawValue),
            productCollectionView.bottomAnchor.constraint(equalTo: topDividerView.topAnchor)
        ])
        presenter?.viewDidLoad()
        
    }
    
    private func setupBottomLabel(label:UILabel,text:String ) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = text
        label.font = .systemFont(ofSize: ConstantValueUI.TotalLabel.font.rawValue)
        contentView.addSubview(label)
    }
    
    private func setupBottomPriceLabel(label:UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: ConstantValueUI.priceLabelFont.rawValue)
        contentView.addSubview(label)
    }
    
    //MARK: - Buttons methods
    @objc private func comeBackButtonTapped(_ sener: UIButton) {
        presenter?.userTapBackButton(navController: self.navigationController)
    }
    
}


//MARK: - PresenterToView methods
extension MyCartViewController:PresenterToViewMyCartProtocol{
    func onSuccessfulFetchData(totalPrice:Int,deliveryPrice:String,productCount:Int) {
        totalPriceLabel.text = "$\(totalPrice) us"
        deliveryPriceLabel.text = deliveryPrice
        delegate?.passProductsCount(count: productCount) // to refresh count of products at cart icon in tab bar
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
    
    func onFailureFetchData(error: String) {
        present(errorAC(error),animated: true)
    }
}

//MARK: - Collection methods
extension MyCartViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfRowsInProductsSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        presenter?.setProductCell(collectionProductView: collectionView, forRowAt: indexPath) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        presenter?.productCellSize(width: contentView.frame.width - 20) ?? CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        presenter?.setProductUIEdgeInsets() ?? UIEdgeInsets()
    }
}
