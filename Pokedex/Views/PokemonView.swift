//
//  MonsterDetails.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 10/2/2026.
//

import SwiftUI

struct PokemonView: View {
    private var viewModel: PokemonViewModel
    private let pokemonNumber: Int
    
    init(pokemonNumber: Int, viewModel: PokemonViewModel) {
        self.viewModel = viewModel
        self.pokemonNumber = pokemonNumber
    }
    
    var body: some View {
        VStack {
            Text("This is the pokemon")
            if let pokemon = viewModel.pokemon {
                Text("Pokemon name is this one \(pokemon.name)")
            }
        }
        .onAppear {
            Task {
                await viewModel.getPokemon()
            }
        }
    }
}
