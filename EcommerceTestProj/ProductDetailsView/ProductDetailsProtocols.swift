import Foundation
import UIKit

//MARK: - View Input (View -> Presenter)
protocol ViewToPresenterProductDetailsProtocol {
    var view:PresenterToViewProductDetailsProtocol? {get set}
    var router:PresenterToRouterProductDetailsProtocol? {get set}
    var interactor:PresenterToInteractorProductDetailsProtocol? {get set}
    func userTapBackButton(navController:UINavigationController?)
    func numberOfRowsAtTopSection() -> Int
    func setCarouselCell(collectionView:UICollectionView, forRowAt indexPath:IndexPath, images:[String]) -> CarouselCollectionViewCell
    func setTopCell(collectionView:UICollectionView,forRowAt indexPath:IndexPath) -> TopCollectionViewCell
    func carouselCellSize() -> CGSize
    func topCellSize(width:CGFloat) -> CGSize
    func carouselUIEdgeInsets() -> UIEdgeInsets
    func topUIEdgeInsets() -> UIEdgeInsets
    func didSelectCarouselCell(carouselCollectionView:UICollectionView, forRowAt indexPath:IndexPath)
    func setShopCell(collectionView:UICollectionView, forRowAt indexPath:IndexPath, productDetails:ProductDetails) -> ShopCollectionViewCell
    func shopCellSize(width:CGFloat, height:CGFloat) -> CGSize
    func shopUIEdgeInsets() -> UIEdgeInsets
    func didSelectTopItemAt(topCollectionView: UICollectionView, indexPath: IndexPath, descriptionalCollectionView: UICollectionView)
}

//MARK: - View Output (Presenter -> View)
protocol PresenterToViewProductDetailsProtocol {

}

//MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorProductDetailsProtocol {
    var presenter:InteractorToPresenterProductDetailsProtocol? {get set}

}

//MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterProductDetailsProtocol {

}

//MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterProductDetailsProtocol {
    static func createModule(productData:ProductDetails) -> ProductDetailsViewController
    func backToMainView(navController:UINavigationController?)
}
