//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Максим on 17.12.2023.
//

import Foundation

protocol ProfileFetchingProtocol {
    func fetchUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void)
}

protocol ProfileUpdatingProtocol {
    func updateUserProfile(with data: UploadProfileModel, completion: @escaping (Result<UserProfile, Error>) -> Void)
}

protocol NFTFetchingProtocol {
    func fetchNFTs(completion: @escaping (Result<[NFTModelProfile], Error>) -> Void)
}

protocol UserDetailProtocol {
    func fetchUserDetails(userId: String, completion: @escaping (Result<UserModel, Error>) -> Void)
}

protocol ProfileServiceProtocol: ProfileFetchingProtocol,
                                 ProfileUpdatingProtocol,
                                 NFTFetchingProtocol,
                                 UserDetailProtocol {}

struct ProfileService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

}

extension ProfileService: ProfileServiceProtocol {
    func fetchUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let request = UserProfileRequest(userId: "1")
        networkClient.send(request: request, type: UserProfile.self, onResponse: completion)
    }

    func updateUserProfile(with data: UploadProfileModel, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let request = UserProfileUpdateRequest(userId: "1", updateProfile: data)
        networkClient.send(request: request, type: UserProfile.self, onResponse: completion)
    }

    func fetchUserDetails(userId: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
            let request = UserDetailRequest(userId: userId)
            networkClient.send(request: request, type: UserModel.self, onResponse: completion)
        }
}

extension ProfileService: NFTFetchingProtocol {
    func fetchNFTs(completion: @escaping (Result<[NFTModelProfile], Error>) -> Void) {
        let request = NFTRequest()
        networkClient.send(request: request, type: [NFTModelProfile].self, onResponse: completion)
    }

}

struct UserProfileRequest: NetworkRequest {
    let userId: String

    var endpoint: URL? {
        return URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/profile/\(userId)")
    }

    var httpMethod: HttpMethod {
        return .get
    }
}

struct UserProfileUpdateRequest: NetworkRequest {
    var userId: String
    let updateProfile: UploadProfileModel

    var endpoint: URL? {
        return URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/profile/\(userId)")
    }

    var httpMethod: HttpMethod {
        return .put
    }

    var dto: Encodable? {
        return updateProfile
    }
}

struct NFTRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/nft")
    }

    var httpMethod: HttpMethod {
        return .get
    }
}

struct UserDetailRequest: NetworkRequest {
    let userId: String

    var endpoint: URL? {
        return URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/users/\(userId)")
    }

    var httpMethod: HttpMethod {
        return .get
    }
}
