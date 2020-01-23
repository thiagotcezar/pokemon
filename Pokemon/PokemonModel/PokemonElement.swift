//
//  PokemonElement.swift
//  Pokemon
//
//  Created by K2 - Thiago Cézar on 22/01/20.
//  Copyright © 2020 Thiago Cézar. All rights reserved.
//

import Foundation
import UIKit

struct PokemonElement: Codable {
    let order, id: Int
    let name: String
    let types: [Types]
    let moves: [Move]
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        case order
        case sprites
        case name
        case moves
        case types
        case id
    }
}

struct Sprites: Codable {
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey{
        case imageUrl = "front_default"
    }
}

struct Move: Codable {
    let ability: MoveDetails
    
    enum CodingKeys: String, CodingKey{
        case ability = "move"
    }
}

struct MoveDetails: Codable {
    let name: String
}

struct Types: Codable{
    let type: TypeDetails
}

struct TypeDetails: Codable{
    let name: String
}

typealias Pokemon = [PokemonElement]

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
