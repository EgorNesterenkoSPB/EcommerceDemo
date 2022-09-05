import Foundation
import UIKit

//MARK: - View Input (View -> Presenter)
protocol ViewToPresenterMyCartProtocol {
    var view:PresenterToViewMyCartProtocol? {get set}
    var router:PresenterToRouterMyCartProtocol? {get set}
    var interactor:PresenterToInteractorMyCartProtocol? {get set}
    func userTapBackButton(navController:UINavigationController?)
    func viewDidLoad()
    func numberOfRowsInProductsSection() -> Int
    func setProductCell(collectionProductView:UICollectionView,forRowAt indexPath:IndexPath) -> ProductCartCollectionViewCell
    func productCellSize(width:CGFloat) -> CGSize
    func setProductUIEdgeInsets() -> UIEdgeInsets
}

//MARK: - View Output (Presenter -> View)
protocol PresenterToViewMyCartProtocol {
    func onSuccessfulFetchData(totalPrice:Int,deliveryPrice:String,productCount:Int)
    func onFailureFetchData(error:String)
}

//MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMyCartProtocol {
    var presenter:InteractorToPresenterMyCartProtocol? {get set}
    func fetchData()
}

//MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMyCartProtocol {
    func successfulFetchData(data:WelcomeMyCart)
    func failureFetchData(error:String)
}

//MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterMyCartProtocol {
    static func createModule() -> MyCartViewController
    func comeBackToRootVC(navController:UINavigationController?)
}

protocol MyCartViewControllerProtocol {
    func passProductsCount(count:Int)
}
