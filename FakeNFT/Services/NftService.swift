import Foundation


typealias NftCompletion = (Result<NFTModelCart, Error>) -> Void

protocol NftServiceProtocol {
    var networkClient: NetworkClient { get }
    func getNft(id: String, completion: @escaping NftCompletion)
}


final class NftService: NftServiceProtocol {

    let networkClient: NetworkClient

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func getNft(id nftId: String, completion: @escaping NftCompletion ) {
        let getRequest = GetNFTRequest(nftId: nftId)


        networkClient.send(request: getRequest, type: NFTModelCart.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}


struct GetNFTRequest: NetworkRequest {
    let nftId: String
    
    var endpoint: URL? {
        URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/nft/\(nftId)")
    }

    
    var httpMethod: HttpMethod {.get}
    
    
}


