//
//  PokemonService.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 16/2/2026.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemonList(requestCount: Int, requestLimit: Int) async throws -> MonsterList
    func fetchPokemon(with: Int) async throws -> Pokemon
}

struct PokemonService: PokemonServiceProtocol {
    func fetchPokemonList(requestCount: Int, requestLimit: Int) async throws -> MonsterList {
        var queryParam = ""
        var endpoint = "/pokemon/"
        let data: Data
        let pokemonList: MonsterList
        
        if requestCount != 0 {
            queryParam = "?offset=\(requestCount*20)&limit=\(requestLimit)"
        }
        
        endpoint = endpoint + queryParam
        do {
            data = try await APIClient.shared.get(endpoint: endpoint)
        } catch {
            throw CustomError.networkError
        }
        
        do {
            pokemonList = try JSONDecoder().decode(MonsterList.self, from: data)
        } catch {
            throw CustomError.decodingError
        }
        
        return pokemonList
    }

    func fetchPokemon(with pokemonNumber: Int) async throws -> Pokemon {
        let endpoint = "/pokemon/\(pokemonNumber)"
        let data: Data
        let pokemon: Pokemon
        
        do {
            data = try await APIClient.shared.get(endpoint: endpoint)
        } catch {
            throw CustomError.networkError
        }
        
        do {
            pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
        } catch {
            throw CustomError.decodingError
        }
        
        return pokemon
    }
}
