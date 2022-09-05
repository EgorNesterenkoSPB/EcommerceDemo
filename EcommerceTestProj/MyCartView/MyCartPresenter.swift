import Foundation
import UIKit

final class MyCartPresenter:ViewToPresenterMyCartProtocol{
    
    var view: PresenterToViewMyCartProtocol?
    var router: PresenterToRouterMyCartProtocol?
    var interactor: PresenterToInteractorMyCartProtocol?
    var cartData:WelcomeMyCart?
    
    func userTapBackButton(navController: UINavigationController?) {
        router?.comeBackToRootVC(navController: navController)
    }
    
    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    func numberOfRowsInProductsSection() -> Int {
        cartData?.basket.count ?? 0
    }
    
    func setProductCell(collectionProductView: UICollectionView, forRowAt indexPath: IndexPath) -> ProductCartCollectionViewCell {
        if let cell = collectionProductView.dequeueReusableCell(withReuseIdentifier: ProductCartCollectionViewCell.identefier, for: indexPath) as? ProductCartCollectionViewCell {
            cell.imageURL = URL(string:cartData?.basket[indexPath.row].images ?? "")
            let productName = cartData?.basket[indexPath.row].title
            cell.nameLabel.text = productName
            cell.priceLabel.text = "$\(cartData?.basket[indexPath.row].price ?? 0)"
            cell.countProductLabel.text = " \(self.getProductCount(productName: productName))"
            return cell
        }
        return ProductCartCollectionViewCell()
    }
    
    private func getProductCount(productName:String?) -> Int {
        guard let cartData = cartData else {return 0}
        var count = 0
        for product in cartData.basket {
            if product.title == productName {
                count += 1
            }
        }
        return count
    }
    
    func productCellSize(width:CGFloat) -> CGSize {
        CGSize(width: width, height: 130)
    }
    
    func setProductUIEdgeInsets() -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension MyCartPresenter:InteractorToPresenterMyCartProtocol {
    func successfulFetchData(data: WelcomeMyCart) {
        self.cartData = data
        
        view?.onSuccessfulFetchData(totalPrice:data.total,deliveryPrice:data.delivery,productCount:data.basket.count)
    }
    
    func failureFetchData(error: String) {
        view?.onFailureFetchData(error: error)
    }
    
    
}
