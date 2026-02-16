//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 10/2/2026.
//

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let abilities: [Ability]
    let baseExperience: Int
    let types: [Type]
    let stats: [Stat]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case sprites
        case abilities
        case baseExperience = "base_experience"
        case types
        case stats
    }
}

struct Sprites: Decodable {
    let other: OtherSprites
}

struct OtherSprites: Decodable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Decodable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Ability: Decodable {
    let ability: AbilityDetails
}

struct AbilityDetails: Decodable {
    let name: String
    let url: String
}

struct Type: Decodable {
    let type: TypeDetails
}

struct TypeDetails: Decodable {
    let name: String
    let url: String
}

struct Stat: Decodable {
    let baseStat: Int
    let stat: StatDetails
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatDetails: Decodable {
    let name: String
    let url: String
}

extension Pokemon {
    var heightDescription: String {
        let heightx10 = height*10
        return "Height: \(heightx10) cms"
    }

    var weightDescription: String {
        let weightx100 = Double(weight) / 10
        return "Weight: \(weightx100) kgs"
    }
}

extension Stat {
    var statDescription: String {
        "\(stat.name.replacingOccurrences(of: "-", with: " ").capitalized): \(String(baseStat))"
    }
}
