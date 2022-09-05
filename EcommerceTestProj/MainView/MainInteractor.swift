import Foundation

final class MainInteractor:PresenterToInteractorMainProtocol {
    
    var presenter: InteractorToPresenterMainProtocol?
    
    func fetchData() {
        
        let network = NetworkManager()
        guard let url = URL(string: ConstantLink.mainDataAPI) else {return}
        network.fetchData(url: url, completion: {[weak self] responseData in
            guard let self = self, let data = responseData.data else {return}
            do {
                let resultsData = try JSONDecoder().decode(WelcomeMain.self, from: data)
                self.presenter?.fetchDataSuccessful(hotSalesData:resultsData.homeStore , bestSellerData: resultsData.bestSeller)
            }
            catch {
                self.presenter?.fetchDataFailure(error: "Coudnt fetch data from server")
            }
        })
    }
    
    func fetchProductData() {
        guard let url = URL(string: ConstantLink.productDetailsDataAPI) else {return}
        NetworkManager().fetchData(url: url, completion: { [weak self] responseData in
            guard let self = self, let data = responseData.data else {return}
            do{
                let productDetails = try JSONDecoder().decode(ProductDetails.self, from: data)
                self.presenter?.fetchProductDataSuccessful(productData: productDetails)
            }
            catch {
                self.presenter?.fetchProductDataFailute(error: "Coudnt fetch data for this product")
            }
        })
    }
}
