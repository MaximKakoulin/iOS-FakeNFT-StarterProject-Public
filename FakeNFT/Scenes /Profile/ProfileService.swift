//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Максим on 17.12.2023.
//

import Foundation

protocol ProfileServiceProtocol {
    func fetchUserProfile(competition: @escaping (Result<UserProfile, Error>) -> Void)
}

struct ProfileService: ProfileServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func fetchUserProfile(competition: @escaping (Result<UserProfile, Error>) -> Void) {
        let request = UserProfileRequest(userId: "1")
        networkClient.send(request: request, type: UserProfile.self, onResponse: competition)
    }
}

struct UserProfileRequest: NetworkRequest {
    let userId: String

    var endpoint: URL? {
        return URL(string: "https://657f05a89d10ccb465d5cbee.mockapi.io/api/v1/profile/\(userId)")
    }

    var httpMethod: HttpMethod {
        return .get
    }
}


