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
        return URL(string: "https://64858e8ba795d24810b71189.mockapi.io/api/v1/profile1/\(userId)")
    }

    var httpMethod: HttpMethod {
        return .get
    }
}

// TODO - вот эту ссыль https://64858e8ba795d24810b71189.mockapi.io/api/v1/profile1 вставить взамен текущей(2 этап) 
