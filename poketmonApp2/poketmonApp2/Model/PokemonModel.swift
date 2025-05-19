//
//  PoketmonModel.swift
//  poketmonApp2
//
//  Created by 최영건 on 5/14/25.
//

import RxSwift
import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonEntry]
}

struct PokemonEntry: Codable {
    let name: String
    let url: String
}

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let types: [PokemonTypeSlot]
    let height: Int
    let weight: Int
    let results: [PokemonEntry]
    let type: [PokemonTypeSlot]
    let sprites: PokemonSprites
}

struct PokemonTypeSlot: Codable {
    let type: PokemonType
    let slot: Int
}

struct PokemonType: Codable {
    let name: String
    let url: String
    
}
struct PokemonDetailResponse: Codable {
    let results: [PokemonEntry]
    
}

struct PokemonSprites: Codable {
    let frontDefault: String?
    
}

enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
}
