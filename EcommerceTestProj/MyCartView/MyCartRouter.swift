import Foundation
import UIKit

final class MyCartRouter:PresenterToRouterMyCartProtocol{
    
    static func createModule() -> MyCartViewController {
        let myCartVC = MyCartViewController()
        
        let presenter:(ViewToPresenterMyCartProtocol & InteractorToPresenterMyCartProtocol) = MyCartPresenter()
        myCartVC.presenter = presenter
        myCartVC.presenter?.interactor = MyCartInteractor()
        myCartVC.presenter?.router = MyCartRouter()
        myCartVC.presenter?.interactor?.presenter = presenter
        myCartVC.presenter?.view = myCartVC
        
        
        return myCartVC
    }
    
    func comeBackToRootVC(navController: UINavigationController?) {
        navController?.popToRootViewController(animated: true)
    }
}
