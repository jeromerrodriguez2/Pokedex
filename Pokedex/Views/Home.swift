//
//  Home.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 9/2/2026.
//

import SwiftUI

struct Home: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var searchString = ""
    @State private var isLoading = false
    @State private var activeTask: Task<Void, Never>?
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(Array(searchResult.enumerated()), id: \.element.id) { index, pokemon in
                        NavigationLink(destination: {
                            PokemonView(
                                viewModel: .init(pokemonNumber: (viewModel.displayedPokemonList.firstIndex { $0.name == pokemon.name } ?? 0) + 1))
                        }, label: {
                            Text(pokemon.name)
                        })
                    }
                }
                .searchable(text: $searchString)

                Button {
                    guard activeTask == nil else { return }
                    activeTask = Task {
                        self.isLoading = true
                        await viewModel.fetchPokemonList()
                        self.isLoading = false
                        activeTask = nil
                    }
                } label: {
                    Text("Load more pokemon")
                }
                .disabled(isLoading == true)
            }
            .navigationTitle("Pokédex")
        }
        .onAppear {
            Task {
                await viewModel.fetchPokemonList()
            }
        }
        
        var searchResult: [MonsterListItem] {
            if searchString.isEmpty {
                return viewModel.displayedPokemonList
            } else {
                return viewModel.displayedPokemonList.filter { $0.name.contains(searchString.lowercased()) }
            }
        }
    }
}
