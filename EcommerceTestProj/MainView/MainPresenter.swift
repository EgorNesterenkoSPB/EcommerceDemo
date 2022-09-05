import Foundation
import UIKit

final class MainPresenter:ViewToPresenterMainProtocol {
    
    var view: PresenterToViewMainProtocol?
    var router: PresenterToRouterMainProtocol?
    var interactor: PresenterToInteractorMainProtocol?
    var categoryArray = [Category(image: "phone", name: ConstantName.phoneCategoryName),Category(image: "desktopcomputer", name: "Computer"),Category(image: "heart", name: "Health"),Category(image: "book", name: "Books"),Category(image: "tv", name: "TV"),Category(image: "gamecontroller", name: "Games"),Category(image: "camera", name: "Cameras")]
    var hotSalesData = [HomeStore]()
    var bestSellerData = [BestSeller]()
    let filteredLauncher = FilteredLauncher()
    
    
    
    //MARK: - Constant UI value
    enum ConstantValueUI:CGFloat {
        case widthCategoryCellSize = 70
        case heightCategoryCellSize = 120
        case bestSellerCellHeight = 200
    }
    
    func numberOfRowsInCategorySection() -> Int {
        categoryArray.count
    }
    
    func userTapFilterButton() {
        var brandsNames = [String]()
        for brand in bestSellerData {
            if let firstWorld = brand.title.components(separatedBy: " ").first { // get brand name
                if brandsNames.contains(firstWorld) { // dont add similar phone name
                    continue
                }
                brandsNames.append(firstWorld)
            }
        }
        filteredLauncher.showBottomView(brands:brandsNames)
    }
    
    
    
    func numberOfRowsInMainSection() -> Int {
        self.categoryArray.count
    }
    
    func setMainCell(collectionMainView: UICollectionView, forRowAt indexPath: IndexPath) -> MainCollectionViewCell {
        if let cell = collectionMainView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identefier, for: indexPath) as? MainCollectionViewCell {
            cell.bestSellerData = self.bestSellerData
            cell.hotSalesData = self.hotSalesData
            cell.delegate = self // to navigate when tapped best seller cell
            DispatchQueue.main.async {
                cell.hotSalesCollectionView.reloadData()
                cell.bestSellerCollectonView.reloadData()
            }
            return cell
        }
        return MainCollectionViewCell()
    }
    
    func setCategoryCell(collectionCetegoryView: UICollectionView, forRowAt indexPath: IndexPath) -> CategoryCollectionViewCell {
        if let cell = collectionCetegoryView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identefier, for: indexPath) as? CategoryCollectionViewCell {
            cell.titleName.text = categoryArray[indexPath.row].name
            cell.img.image = UIImage(systemName: categoryArray[indexPath.row].image)
            return cell
        }
        return CategoryCollectionViewCell()
    }
    
    func categoryCellSize() -> CGSize {
        CGSize(width: ConstantValueUI.widthCategoryCellSize.rawValue, height: ConstantValueUI.heightCategoryCellSize.rawValue)
    }
    
    func setCategoryUIEdgeInsets() -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func setMainCellSize(width: CGFloat, height: CGFloat) -> CGSize {
        CGSize(width: width, height: height)
    }
    
    func setMainCellUIEdgeInsets() -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func didSelectCategoryItemAt(categoryCollectionView:UICollectionView,indexPath: IndexPath,mainCollectionView:UICollectionView) {
        mainCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    func userTapMyCartButton(mainViewController:MainViewController) {
        router?.showMyCartView(mainViewController: mainViewController)
    }
    
}

extension MainPresenter:InteractorToPresenterMainProtocol {
    
    func fetchDataSuccessful(hotSalesData: [HomeStore], bestSellerData: [BestSeller]) {
        self.hotSalesData = hotSalesData
        self.bestSellerData = bestSellerData
        view?.onFetchDataSuccessful()
    }
    
    func fetchDataFailure(error: String) {
        view?.onFetchDataFailure(error: error)
    }
    
    func fetchProductDataSuccessful(productData: ProductDetails) {
        router?.showProductDetailsView(productData: productData)
    }
    
    func fetchProductDataFailute(error: String) {
        view?.onFetchProductDataFailure(error: error)
    }
    
    
}

extension MainPresenter:MainCellProtocol {
    func bestSellerCellTapped() {
        interactor?.fetchProductData()
    }
    
    
}

