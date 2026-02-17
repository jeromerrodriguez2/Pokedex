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
    private let service: PokemonServiceProtocol
    
    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
    }

    @MainActor
    func fetchPokemonList() async {
        do {
            let pokemonList = try await service.fetchPokemonList(requestCount: requestCount, requestLimit: 20)
            displayedPokemonList = displayedPokemonList + pokemonList.results
        } catch {
            // Return a meaningful error message here like a specific enum that we can display to the user
            print("Get method failed")
        }
        requestCount += 1
    }
}
