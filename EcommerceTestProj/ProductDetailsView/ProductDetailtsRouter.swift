import Foundation
import UIKit

final class ProductDetailsRouter:PresenterToRouterProductDetailsProtocol {
    
    static func createModule(productData:ProductDetails) -> ProductDetailsViewController {
        let productDetailsVC = ProductDetailsViewController(productData: productData)
        
        let presenter:(ViewToPresenterProductDetailsProtocol & InteractorToPresenterProductDetailsProtocol) = ProductDetailsPresenter()
        productDetailsVC.presenter = presenter
        productDetailsVC.presenter?.interactor = ProductDetailsInteractor()
        productDetailsVC.presenter?.view = productDetailsVC
        productDetailsVC.presenter?.interactor?.presenter = presenter
        productDetailsVC.presenter?.router = ProductDetailsRouter()
        
        
        return productDetailsVC
    }
    
    func backToMainView(navController: UINavigationController?) {
        navController?.popToRootViewController(animated: true)
    }
    
}
