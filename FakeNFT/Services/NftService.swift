import Foundation

typealias NftCompletion = (Result<NFTModel, Error>) -> Void

protocol NftServiceProtocol {
    var networkClient: NetworkClient { get }
    func getNft(id: String, completion: @escaping NftCompletion)
}

final class NftService: NftServiceProtocol {

    let networkClient: NetworkClient

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func getNft(id NftID: String, completion: @escaping NftCompletion ) {
        let getRequest = GetNFTRequest(nftId: NftID)
        print(NftID)
        networkClient.send(request: getRequest, type: NFTModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

//TODO: - Вынести в одлеьный файл и добавить ссылку на новй api
struct GetNFTRequest: NetworkRequest {
    let nftId: String
    var endpoint: URL? {
        URL(string: "https://64c51731c853c26efada7bb6.mockapi.io/api/v1/nft/\(nftId)")
//        Constants.endpoint.appendingPathComponent("/api/v1/nft/\(NFTID)")
    }
    
    var httpMethod: HttpMethod {.get}
    
    
}
