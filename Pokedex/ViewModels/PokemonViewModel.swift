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
    @Published var errorMessage = ""

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
            if let customError = error as? CustomError {
                errorMessage = switch customError {
                case .networkError:
                    "Network error occured. Please try again."
                case .decodingError:
                    "Decoding error. Please contact app owner"
                case .unknownError:
                    "Unknown error. Please contact app owner"
                }
            } else {
                errorMessage = "Unknown error. Please contact app owner"
            }
        }
    }
}
