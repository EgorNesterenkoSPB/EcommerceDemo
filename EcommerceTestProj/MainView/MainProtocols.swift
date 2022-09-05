import Foundation
import UIKit

//MARK: - View Input (View -> Presenter)
protocol ViewToPresenterMainProtocol {
    var view:PresenterToViewMainProtocol? {get set}
    var router:PresenterToRouterMainProtocol? {get set}
    var interactor:PresenterToInteractorMainProtocol? {get set}
    func numberOfRowsInCategorySection() -> Int
    func setCategoryCell(collectionCetegoryView:UICollectionView,forRowAt indexPath:IndexPath) -> CategoryCollectionViewCell
    func categoryCellSize() -> CGSize
    func setCategoryUIEdgeInsets() -> UIEdgeInsets
    func didSelectCategoryItemAt(categoryCollectionView:UICollectionView,indexPath:IndexPath,mainCollectionView:UICollectionView)
    func viewDidLoad()
    func numberOfRowsInMainSection() -> Int
    func setMainCellSize(width:CGFloat,height:CGFloat) -> CGSize
    func setMainCellUIEdgeInsets() -> UIEdgeInsets
    func setMainCell(collectionMainView:UICollectionView,forRowAt indexPath:IndexPath) -> MainCollectionViewCell
    func userTapFilterButton()
    func userTapMyCartButton(mainViewController:MainViewController)
}

//MARK: - View Output (Presenter -> View)
protocol PresenterToViewMainProtocol {
    func onFetchDataSuccessful()
    func onFetchDataFailure(error:String)
    func onFetchProductDataFailure(error:String)
}

//MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMainProtocol {
    var presenter:InteractorToPresenterMainProtocol? {get set}
    func fetchData()
    func fetchProductData()
}

//MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMainProtocol {
    func fetchDataSuccessful(hotSalesData:[HomeStore],bestSellerData:[BestSeller])
    func fetchDataFailure(error:String)
    func fetchProductDataSuccessful(productData:ProductDetails)
    func fetchProductDataFailute(error:String)
}

//MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterMainProtocol {
    static func createMainModule() -> UINavigationController
    func showProductDetailsView(productData:ProductDetails)
    func showMyCartView(mainViewController:MainViewController)
}
