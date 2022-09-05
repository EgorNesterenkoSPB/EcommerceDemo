import UIKit

protocol MainCellProtocol {
    func bestSellerCellTapped()
}

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identefier = "mainCell"
    let hotSalesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let bestSellerCollectonView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var hotSalesData = [HomeStore]()
    var bestSellerData = [BestSeller]()
    
    var delegate:MainCellProtocol?
    
    enum ConstantValueUI:CGFloat {
        case hotSalesHeightCell = 150
        case bestSellerCellHeight = 200
        case labelFont = 25
        case fontSizeLittleOrangeButton = 16
        enum HotSalesCollectView:CGFloat {
            case topAndLeftAnchor = 10
        }
        enum BestSellerLabel:CGFloat {
            case topAnchor = 10
        }
        enum BestSellerCollectView:CGFloat {
            case topAndBottomAnchor = 5
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        
        let bestSellerLabel = UILabel()
        bestSellerLabel.translatesAutoresizingMaskIntoConstraints = false
        bestSellerLabel.text = "Best Seller"
        bestSellerLabel.font = .boldSystemFont(ofSize: ConstantValueUI.labelFont.rawValue)
        bestSellerLabel.textColor = UIColor(named: ConstantName.tabBarColorName)
        self.addSubview(bestSellerLabel)
        
        let seeMoreButton = UIButton()
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        seeMoreButton.setTitle("see more", for: .normal)
        seeMoreButton.setTitleColor(UIColor(named: ConstantName.orangeMainColor), for: .normal)
        seeMoreButton.titleLabel?.font = .systemFont(ofSize: ConstantValueUI.fontSizeLittleOrangeButton.rawValue)
        seeMoreButton.backgroundColor = .clear
        self.addSubview(seeMoreButton)
        
        let hotSalesFlowLayout = UICollectionViewFlowLayout.init()
        hotSalesFlowLayout.scrollDirection = .horizontal
        hotSalesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hotSalesCollectionView.setCollectionViewLayout(hotSalesFlowLayout, animated: true)
        hotSalesCollectionView.dataSource = self
        hotSalesCollectionView.delegate = self
        hotSalesCollectionView.backgroundColor = .clear
        hotSalesCollectionView.alwaysBounceHorizontal = true
        hotSalesCollectionView.showsHorizontalScrollIndicator = false
        hotSalesCollectionView.register(HotSalesCollectionViewCell.self, forCellWithReuseIdentifier: HotSalesCollectionViewCell.identefier)
        self.addSubview(hotSalesCollectionView)
        
        let bestSellerFlowLayout = UICollectionViewFlowLayout.init()
        bestSellerFlowLayout.scrollDirection = .vertical
        bestSellerCollectonView.translatesAutoresizingMaskIntoConstraints = false
        bestSellerCollectonView.setCollectionViewLayout(bestSellerFlowLayout, animated: true)
        bestSellerCollectonView.dataSource = self
        bestSellerCollectonView.delegate = self
        bestSellerCollectonView.backgroundColor = .clear
        bestSellerCollectonView.alwaysBounceVertical = true
        bestSellerCollectonView.register(BestSellerCollectionViewCell.self, forCellWithReuseIdentifier: BestSellerCollectionViewCell.identefier)
        bestSellerCollectonView.showsVerticalScrollIndicator = false
        self.addSubview(bestSellerCollectonView)
        
        NSLayoutConstraint.activate([
            hotSalesCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            hotSalesCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            hotSalesCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10),
            hotSalesCollectionView.heightAnchor.constraint(equalToConstant: ConstantValueUI.hotSalesHeightCell.rawValue),
            bestSellerLabel.topAnchor.constraint(equalTo: hotSalesCollectionView.bottomAnchor, constant: ConstantValueUI.BestSellerLabel.topAnchor.rawValue),
            bestSellerLabel.leftAnchor.constraint(equalTo: hotSalesCollectionView.leftAnchor),
            seeMoreButton.centerYAnchor.constraint(equalTo: bestSellerLabel.centerYAnchor),
            seeMoreButton.rightAnchor.constraint(equalTo: hotSalesCollectionView.rightAnchor),
            bestSellerCollectonView.topAnchor.constraint(equalTo: bestSellerLabel.bottomAnchor, constant: ConstantValueUI.BestSellerCollectView.topAndBottomAnchor.rawValue),
            bestSellerCollectonView.leftAnchor.constraint(equalTo: bestSellerLabel.leftAnchor),
            bestSellerCollectonView.rightAnchor.constraint(equalTo: seeMoreButton.rightAnchor),
            bestSellerCollectonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ConstantValueUI.BestSellerCollectView.topAndBottomAnchor.rawValue)
        ])
    }
    
}

//MARK: - Collection methods
extension MainCollectionViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case hotSalesCollectionView:
            return self.hotSalesData.count
        case bestSellerCollectonView:
            return self.bestSellerData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case hotSalesCollectionView:
            return self.setHotSalesCell(collectionHotSalesView: collectionView, forRowAt: indexPath)
        case bestSellerCollectonView:
            return self.setBestSellerCell(collectionBestSellerView: collectionView, forRowAt: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case bestSellerCollectonView:
            return 2
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case hotSalesCollectionView:
            return CGSize(width: self.frame.width, height: ConstantValueUI.hotSalesHeightCell.rawValue)
        case bestSellerCollectonView:
            return CGSize(width: (self.frame.width / 2) - 25, height: ConstantValueUI.bestSellerCellHeight.rawValue)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case hotSalesCollectionView:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case bestSellerCollectonView:
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        default:
            return UIEdgeInsets()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case bestSellerCollectonView:
            delegate?.bestSellerCellTapped()
        default:
            return
        }
    }
    
    
}

//MARK: - Setup Collections Cells
extension MainCollectionViewCell {
    private func setHotSalesCell(collectionHotSalesView: UICollectionView, forRowAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionHotSalesView.dequeueReusableCell(withReuseIdentifier: HotSalesCollectionViewCell.identefier, for: indexPath) as? HotSalesCollectionViewCell {
            cell.nameTitle.text = self.hotSalesData[indexPath.row].title
            cell.descriptionSubtitle.text = self.hotSalesData[indexPath.row].subtitle
            cell.imageURL = URL(string: self.hotSalesData[indexPath.row].picture)
            if let isNew = self.hotSalesData[indexPath.row].isNew {
                cell.isNew = isNew
            }
            return cell
        }
        return HotSalesCollectionViewCell()
    }
    
    private func setBestSellerCell(collectionBestSellerView: UICollectionView, forRowAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionBestSellerView.dequeueReusableCell(withReuseIdentifier: BestSellerCollectionViewCell.identefier, for: indexPath) as? BestSellerCollectionViewCell {
            cell.name.text = bestSellerData[indexPath.row].title
            cell.priceWithOutDiscondLabel.attributedText = NSAttributedString(string: String("$\(bestSellerData[indexPath.row].priceWithoutDiscount)"), attributes: [NSAttributedString.Key.strikethroughStyle:NSUnderlineStyle.single.rawValue]) // to add cross off
            cell.priceWithDiscondLabel.text = String("$\(bestSellerData[indexPath.row].discountPrice)")
            if bestSellerData[indexPath.row].isFavorites {
                
            }
            cell.imageURL = URL(string: bestSellerData[indexPath.row].picture)
            return cell
        }
        return BestSellerCollectionViewCell()
    }
}

