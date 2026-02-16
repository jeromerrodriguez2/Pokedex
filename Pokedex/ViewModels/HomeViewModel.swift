//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 10/2/2026.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var displayedPokemonList: [MonsterListItem] = []
    private var requestCount = 0
    
    @MainActor
    func fetchPokemonList() async {
        var queryParam = ""
        if requestCount != 0 {
            queryParam = "?offset=\(requestCount*20)&limit=20"
        }
        do {
            let endpoint = "/pokemon/\(queryParam)"
            print(endpoint)
            let data = try await APIClient.shared.get(endpoint: endpoint)
            
            let pokemonList = try JSONDecoder().decode(MonsterList.self, from: data)
            displayedPokemonList = displayedPokemonList + pokemonList.results
            print("Pokemon count: \(displayedPokemonList.count)")
        } catch {
            print("Get method failed")
        }
        requestCount += 1
    }
}
