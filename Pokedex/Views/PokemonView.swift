//
//  MonsterDetails.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 10/2/2026.
//

import SwiftUI

struct PokemonView: View {
    @ObservedObject var viewModel: PokemonViewModel
    
    init(viewModel: PokemonViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    if let imageURL = viewModel.imageURL {
                        CachedAsyncImage(
                            url: imageURL,
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            }, placeholder: {
                                ProgressView()
                            })
                    }
                    
                    if let pokemon = viewModel.pokemon {
                        Text(pokemon.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    } else {
                        Text("Pokemon is missing")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 24)
                
                VStack(alignment: .leading, spacing: 8) {
                    if let id = viewModel.pokemon?.id {
                        Text("ID: \(id.description)")
                            .font(.title2)
                    }

                    if let baseExperience = viewModel.pokemon?.baseExperience {
                        Text("Base experience: \(baseExperience.description)")
                            .font(.title2)
                    }
                    
                    if let height = viewModel.pokemon?.heightDescription {
                        Text(height)
                            .font(.title2)
                    }
                    
                    if let weight = viewModel.pokemon?.weightDescription {
                        Text(weight)
                            .font(.title2)
                    }
                    
                    Text("Types")
                        .font(.title2)
                    
                    if let types = viewModel.pokemon?.types {
                        ForEach(types, id: \.type.name) { typeDetails in
                            Text(typeDetails.type.name)
                                .font(.title3)
                        }
                    }
                    
                    Text("Abilities")
                        .font(.title2)
                    if let abilities = viewModel.pokemon?.abilities {
                        ForEach(abilities, id: \.ability.name) { abilityDetails in
                            Text(abilityDetails.ability.name)
                                .font(.title3)
                        }
                    }
                    
                    Text("Stats")
                        .font(.title2)
                    if let stats = viewModel.pokemon?.stats {
                        ForEach(stats, id: \.stat.name) { statDetails in
                            Text(statDetails.statDescription)
                                .font(.title3)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
        }
        .onAppear {
            Task {
                await viewModel.getPokemon()
            }
        }
    }
}
