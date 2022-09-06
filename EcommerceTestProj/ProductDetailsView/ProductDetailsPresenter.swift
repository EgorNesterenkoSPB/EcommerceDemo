import Foundation
import UIKit

final class ProductDetailsPresenter:ViewToPresenterProductDetailsProtocol{
    
    var view: PresenterToViewProductDetailsProtocol?
    var router: PresenterToRouterProductDetailsProtocol?
    var interactor: PresenterToInteractorProductDetailsProtocol?
    let topCellslabel = ["Shop","Details","Features"]
    
    func userTapBackButton(navController: UINavigationController?) {
        router?.backToMainView(navController: navController)
       }
    
    func didSelectTopItemAt(topCollectionView: UICollectionView, indexPath: IndexPath, descriptionalCollectionView: UICollectionView) {
        descriptionalCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func numberOfRowsAtTopSection() -> Int {
        topCellslabel.count
    }
    
    func setTopCell(collectionView: UICollectionView, forRowAt indexPath: IndexPath) -> TopCollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identefier, for: indexPath) as? TopCollectionViewCell {
            cell.nameLabel.text = topCellslabel[indexPath.row]
            return cell
        }
        return TopCollectionViewCell()
    }
    
    func carouselCellSize() -> CGSize {
        CGSize(width: 100, height: 200)
    }
    
    func topCellSize(width:CGFloat) -> CGSize {
        CGSize(width: width, height: 40)
    }
    
    func carouselUIEdgeInsets() -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func topUIEdgeInsets() -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func didSelectCarouselCell(carouselCollectionView: UICollectionView, forRowAt indexPath: IndexPath) {
        
    }
    
    func didSelectTopCell(topCollectionView: UICollectionView, forRowAt indexPath: IndexPath) {
        
    }
    
    func setShopCell(collectionView: UICollectionView, forRowAt indexPath: IndexPath, productDetails:ProductDetails) -> ShopCollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.identefier, for: indexPath) as? ShopCollectionViewCell {
            cell.cameraSublabel.text = productDetails.camera
            cell.cpuSublabel.text = productDetails.cpu
            cell.sdSublabel.text = productDetails.sd
            cell.ssdSublabel.text = productDetails.ssd
            cell.firstCapacityButton.setTitle("\(productDetails.capacity[0]) GB", for: .normal)
            cell.secondCapacityButton.setTitle("\(productDetails.capacity[1]) gb", for: .normal)
            cell.firstColorCircleButton.tintColor = UIColor(hexString: productDetails.color[0])
            cell.secondColorCircleButton.tintColor = UIColor(hexString: productDetails.color[1])
            return cell
        }
        return ShopCollectionViewCell()
    }
    
    func shopCellSize(width:CGFloat, height:CGFloat) -> CGSize {
        CGSize(width: width, height: height)
    }
    
    func shopUIEdgeInsets() -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension ProductDetailsPresenter:InteractorToPresenterProductDetailsProtocol{


}
