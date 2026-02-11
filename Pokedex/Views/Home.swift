//
//  Home.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 9/2/2026.
//

import SwiftUI

struct Home: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let list = viewModel.pokemonList {
                    List {
                        ForEach(Array(list.results.enumerated()), id: \.element.name) { index, pokemon in
                            NavigationLink(destination: {
                                PokemonView(pokemonNumber: index + 1, viewModel: .init(pokemonNumber: index + 1)) // This is getting called twice
                            }, label: {
                                Text(pokemon.name)
                            })
                        }
                    }
                }
            }
            .navigationTitle("Pokédex")
        }
        .onAppear {
            Task {
                await viewModel.fetchPokemonList()
            }
        }
    }
}

#Preview {
    Home()
}
