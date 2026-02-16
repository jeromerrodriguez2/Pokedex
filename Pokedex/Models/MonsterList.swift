//
//  MonsterList.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 10/2/2026.
//

import Foundation

struct MonsterList: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [MonsterListItem]
}

struct MonsterListItem: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
}
