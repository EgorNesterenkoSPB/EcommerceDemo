import Foundation

final class MyCartInteractor:PresenterToInteractorMyCartProtocol{
    
    var presenter: InteractorToPresenterMyCartProtocol?
    
    func fetchData() {
        let network = NetworkManager()
        guard let url = URL(string: ConstantLink.myCartDataAPI) else {return}
        network.fetchData(url: url, completion: { [weak self] responseData in
            guard let self = self,let data = responseData.data else {return}
            do {
                let resultsData = try JSONDecoder().decode(WelcomeMyCart.self, from: data)
                self.presenter?.successfulFetchData(data: resultsData)
            }
            catch {
                self.presenter?.failureFetchData(error: "Coudnt get products from cart")
            }
        })
    }
    
}
