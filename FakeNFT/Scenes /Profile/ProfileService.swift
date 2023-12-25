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

protocol ProfileServiceProtocol: ProfileFetchingProtocol, ProfileUpdatingProtocol {}

struct ProfileService: ProfileServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func fetchUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let request = UserProfileRequest(userId: "1")
        networkClient.send(request: request, type: UserProfile.self, onResponse: completion)
    }

    func updateUserProfile(with data: UploadProfileModel, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let request = UserProfileUpdateRequest(userId: "1", updateProfile: data)
        networkClient.send(request: request, type: UserProfile.self, onResponse: completion)
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
