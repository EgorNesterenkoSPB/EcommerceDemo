import UIKit

final class MainViewController: UIViewController {
    
    let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let myCartButton = UIButton()
    
    var presenter:(ViewToPresenterMainProtocol & InteractorToPresenterMainProtocol)?
    var rightButtonItem = UIBarButtonItem()
    
    //MARK: - Enum UI constants
    enum ConstantValueUI:CGFloat {
        case fontSizeLittleOrangeButton = 16
        case spcBetweenTBAndButSV = 30
        case labelFont = 25
        case tabbarCornerRadiues = 20
        case explorerButtonLabelFont = 18
        case tabbarHeightAnchor = 70
        case filterButtonRightAnchor = -15
        
        enum MainCollectionView:CGFloat {
            case leftAnchor = 10
        }
        
        enum SelectCategoryLabel:CGFloat {
            case topAndLeftAnchor = 10
        }
        enum ViewAllButton:CGFloat {
            case topAnchor = 10
        }
        enum CategoryCollectView:CGFloat {
            case topAnchor = 0
            case height = 120
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    //MARK: - SetupView
    private func setupView() {
        self.view.backgroundColor = .secondarySystemBackground
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        let selectCategoryLabel = UILabel()
        selectCategoryLabel.text = "Select Category"
        selectCategoryLabel.font = .boldSystemFont(ofSize: ConstantValueUI.labelFont.rawValue)
        selectCategoryLabel.textColor = UIColor(named: ConstantName.tabBarColorName)
        selectCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(selectCategoryLabel)
        
        let filterButton = UIButton()
        filterButton.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        filterButton.tintColor = UIColor(named: ConstantName.tabBarColorName)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.addTarget(self, action: #selector(filteredButtonTapped(_:)), for: .touchUpInside)
        scrollView.addSubview(filterButton)
        
        let viewAllButton = UIButton()
        viewAllButton.setTitle("view all", for: .normal)
        viewAllButton.titleLabel?.font = .systemFont(ofSize: ConstantValueUI.fontSizeLittleOrangeButton.rawValue)
        viewAllButton.setTitleColor(UIColor(named: ConstantName.orangeMainColor), for: .normal)
        viewAllButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(viewAllButton)
        
        let categoryFlowLayout = UICollectionViewFlowLayout.init()
        categoryFlowLayout.scrollDirection = .horizontal
        
        categoryCollectionView.setCollectionViewLayout(categoryFlowLayout, animated: true)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.backgroundColor = .clear
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identefier)
        categoryCollectionView.alwaysBounceHorizontal = true
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        scrollView.addSubview(categoryCollectionView)
        
        let mainFlowLayout = UICollectionViewFlowLayout.init()
        mainFlowLayout.scrollDirection = .horizontal
        mainFlowLayout.minimumLineSpacing = 0
        mainCollectionView.setCollectionViewLayout(mainFlowLayout, animated: true)
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.backgroundColor = .clear
        mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identefier)
        mainCollectionView.isPagingEnabled = true
        mainCollectionView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(mainCollectionView)
        
        
        let tabbarView = UIView()
        tabbarView.translatesAutoresizingMaskIntoConstraints = false
        tabbarView.backgroundColor = UIColor(named: ConstantName.tabBarColorName)
        tabbarView.layer.cornerRadius = ConstantValueUI.tabbarCornerRadiues.rawValue
        tabbarView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        tabbarView.clipsToBounds = true
        
        let explorerButton = UIButton()
        explorerButton.setTitle("Explorer", for: .normal)
        explorerButton.titleLabel?.font = .boldSystemFont(ofSize: ConstantValueUI.explorerButtonLabelFont.rawValue)
        explorerButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        explorerButton.imageView?.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        explorerButton.setTitleColor(.white, for:.normal)
        explorerButton.tintColor = .white
        explorerButton.translatesAutoresizingMaskIntoConstraints = false
        explorerButton.backgroundColor = .clear
        
        
        myCartButton.setImage(UIImage(systemName: ConstantName.cartImageName), for: .normal)
        myCartButton.imageView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.3)
        myCartButton.tintColor = .white
        myCartButton.backgroundColor = .clear
        myCartButton.translatesAutoresizingMaskIntoConstraints = false
        myCartButton.addTarget(self, action: #selector(myCartButtonTapped(_:)), for: .touchUpInside)
        rightButtonItem = UIBarButtonItem(customView: myCartButton)
        rightButtonItem.setBadge(text: "0")
        
        let favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.imageView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.3)
        favoriteButton.tintColor = .white
        favoriteButton.backgroundColor = .clear
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        let profileButton = UIButton()
        profileButton.setImage(UIImage(systemName: "person"), for: .normal)
        profileButton.imageView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.3)
        profileButton.tintColor = .white
        profileButton.backgroundColor = .clear
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalButtonsStack = UIStackView()
        horizontalButtonsStack.axis = NSLayoutConstraint.Axis.horizontal
        horizontalButtonsStack.distribution = UIStackView.Distribution.equalSpacing
        horizontalButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalButtonsStack.alignment = .center
        horizontalButtonsStack.addArrangedSubview(explorerButton)
        horizontalButtonsStack.addArrangedSubview(myCartButton)
        horizontalButtonsStack.addArrangedSubview(favoriteButton)
        horizontalButtonsStack.addArrangedSubview(profileButton)
        tabbarView.addSubview(horizontalButtonsStack)
        
        scrollView.addSubview(tabbarView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            tabbarView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tabbarView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            tabbarView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            tabbarView.heightAnchor.constraint(equalToConstant: ConstantValueUI.tabbarHeightAnchor.rawValue),
            horizontalButtonsStack.centerYAnchor.constraint(equalTo: tabbarView.centerYAnchor),
            horizontalButtonsStack.leftAnchor.constraint(equalTo: tabbarView.leftAnchor,constant: ConstantValueUI.spcBetweenTBAndButSV.rawValue),
            horizontalButtonsStack.rightAnchor.constraint(equalTo: tabbarView.rightAnchor,constant: -ConstantValueUI.spcBetweenTBAndButSV.rawValue),
            selectCategoryLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,constant: ConstantValueUI.SelectCategoryLabel.topAndLeftAnchor.rawValue),
            selectCategoryLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: ConstantValueUI.SelectCategoryLabel.topAndLeftAnchor.rawValue),
            filterButton.centerYAnchor.constraint(equalTo: selectCategoryLabel.centerYAnchor),
            filterButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,constant: ConstantValueUI.filterButtonRightAnchor.rawValue),
            viewAllButton.topAnchor.constraint(equalTo: filterButton.bottomAnchor,constant: ConstantValueUI.ViewAllButton.topAnchor.rawValue),
            viewAllButton.rightAnchor.constraint(equalTo: filterButton.rightAnchor),
            categoryCollectionView.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor,constant: ConstantValueUI.CategoryCollectView.topAnchor.rawValue),
            categoryCollectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            categoryCollectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: ConstantValueUI.CategoryCollectView.height.rawValue),
            mainCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: tabbarView.topAnchor),
            mainCollectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: ConstantValueUI.MainCollectionView.leftAnchor.rawValue),
            mainCollectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
        presenter?.viewDidLoad()
    }
    
    //MARK: - Buttons methods
    @objc private func filteredButtonTapped(_ sender:UIButton) {
        presenter?.userTapFilterButton()
    }
    
    @objc private func myCartButtonTapped(_ sender:UIButton) {
        presenter?.userTapMyCartButton(mainViewController: self)
    }
}

//MARK: - PresenterToView methods
extension MainViewController:PresenterToViewMainProtocol {
    func onFetchProductDataFailure(error: String) {
        present(errorAC(error),animated: true)
    }
    
    func onFetchDataSuccessful() {
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    func onFetchDataFailure(error: String) {
        present(errorAC(error),animated: true)
    }
}

//MARK: - CollectionView methods
extension MainViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return presenter?.numberOfRowsInCategorySection() ?? 0
        case mainCollectionView:
            return presenter?.numberOfRowsInMainSection() ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            return presenter?.setCategoryCell(collectionCetegoryView: collectionView, forRowAt: indexPath) ?? UICollectionViewCell()
        case mainCollectionView:
            return presenter?.setMainCell(collectionMainView: collectionView, forRowAt: indexPath) ?? UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case categoryCollectionView:
            return presenter?.categoryCellSize() ?? CGSize()
        case mainCollectionView:
            return presenter?.setMainCellSize(width: UIScreen.main.bounds.width - ConstantValueUI.MainCollectionView.leftAnchor.rawValue, height: collectionView.frame.height) ?? CGSize()
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case categoryCollectionView:
            return presenter?.setCategoryUIEdgeInsets() ?? UIEdgeInsets()
        case mainCollectionView:
            return presenter?.setMainCellUIEdgeInsets() ?? UIEdgeInsets()
        default:
            return UIEdgeInsets()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryCollectionView:
            presenter?.didSelectCategoryItemAt(categoryCollectionView:collectionView,indexPath: indexPath,mainCollectionView:mainCollectionView)
        default:
            return
        }
    }
     
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / (view.frame.width - ConstantValueUI.MainCollectionView.leftAnchor.rawValue)
        let indexPath = IndexPath(item: Int(index), section: 0)
        categoryCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        presenter?.didSelectCategoryItemAt(categoryCollectionView: categoryCollectionView, indexPath: indexPath, mainCollectionView: mainCollectionView)
    }

}

//MARK: - MyCartVC methods
extension MainViewController:MyCartViewControllerProtocol {
    func passProductsCount(count: Int) {
        rightButtonItem.updateBadge(number: count)
        
    }
    
    
}
