//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 10/2/2026.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var displayedPokemonList: [MonsterListItem] = []
    @Published var errorMessage = ""
    
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
        requestCount += 1
    }
}
