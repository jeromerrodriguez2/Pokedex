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
    private let service: PokemonServiceProtocol

    init(pokemonNumber: Int, service: PokemonServiceProtocol = PokemonService()) {
        self.pokemonNumber = pokemonNumber
        self.service = service
    }
        
    @MainActor
    func getPokemon() async {
        
        do {
            pokemon = try await service.fetchPokemon(with: pokemonNumber)
            if let defaultImageURL = pokemon?.sprites.other.officialArtwork.frontDefault {
                imageURL = URL(string: defaultImageURL)
            }
            
        } catch {
            print("Pokemon get failed")
        }
    }
}
