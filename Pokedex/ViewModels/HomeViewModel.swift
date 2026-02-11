//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 10/2/2026.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var pokemonList: MonsterList?
    
    @MainActor
    func fetchPokemonList() async {
        do {
            let data = try await APIClient.shared.get(endpoint: "/pokemon/")
            
            pokemonList = try JSONDecoder().decode(MonsterList.self, from: data)
        } catch {
            print("Get method failed")
        }
    }
}
