//
//  APIClient.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 10/2/2026.
//

import Foundation

final class APIClient {
    static let shared = APIClient()
    private let baseURL = "https://pokeapi.co/api/v2"
    
    private init() {}
    
    func get(endpoint: String) async throws -> Data {
        // TODO: Introduce proper error when URL initialisation returns nil
        
        let url = URL(string: baseURL + endpoint)!

        let (data, _) = try await URLSession.shared.data(from: url)
        
        return data
    }
}
