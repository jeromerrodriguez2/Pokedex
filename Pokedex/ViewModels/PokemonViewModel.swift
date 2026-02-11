//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 10/2/2026.
//

import Foundation

final class PokemonViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    private let pokemonNumber: Int
    
    init(pokemonNumber: Int) {
        self.pokemonNumber = pokemonNumber
    }
    
    func getPokemon() async {
        let endpoint = "/pokemon/\(pokemonNumber)"
        
        do {
            let data = try await APIClient.shared.get(endpoint: endpoint)
            pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            print("Pokemon get success")
        } catch {
            print("Pokemon get failed")
        }
    }
}
