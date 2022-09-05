import Foundation
import UIKit

final class MainRouter:PresenterToRouterMainProtocol {
    
    let navigationController:UINavigationController
    
    init(navController:UINavigationController) {
        self.navigationController = navController
    }
    
    func showProductDetailsView(productData:ProductDetails) {
        let productDetailsVC = ProductDetailsRouter.createModule(productData: productData)
        navigationController.pushViewController(productDetailsVC, animated: true)
    }
    
    
    static func createMainModule() -> UINavigationController {
        let mainVC = MainViewController()
        let navController = UINavigationController(rootViewController: mainVC)
        let presenter:(ViewToPresenterMainProtocol & InteractorToPresenterMainProtocol) = MainPresenter()
        
        mainVC.presenter = presenter
        mainVC.presenter?.view = mainVC
        mainVC.presenter?.interactor = MainInteractor()
        mainVC.presenter?.router = MainRouter(navController: navController)
        mainVC.presenter?.interactor?.presenter = presenter
        
        return navController
    }
    
    func showMyCartView(mainViewController:MainViewController) {
        let myCartViewController = MyCartRouter.createModule()
        myCartViewController.delegate = mainViewController
        navigationController.pushViewController(myCartViewController, animated: true)
    }
}
