//
//  MonsterList.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 10/2/2026.
//

struct MonsterList: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [MonsterListItem]
}

struct MonsterListItem: Decodable {
    let name: String
    let url: String
}
