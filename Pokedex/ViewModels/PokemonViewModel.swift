//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 10/2/2026.
//

import Foundation

final class PokemonViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    @Published var imageURL: URL?
    private let pokemonNumber: Int

    init(pokemonNumber: Int) {
        self.pokemonNumber = pokemonNumber
    }
    
    @MainActor
    func getPokemon() async {
        let endpoint = "/pokemon/\(pokemonNumber)"
        print("Pokemon number is \(pokemonNumber)")
        
        do {
            let data = try await APIClient.shared.get(endpoint: endpoint)
            pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            if let frontDefault = pokemon?.sprites.other.officialArtwork.frontDefault {
                imageURL = URL(string: frontDefault)
            }
            
        } catch {
            print("Pokemon get failed")
        }
    }
}
