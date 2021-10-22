//
//  Pokemon.swift
//  AjaibPokemonProject
//
//  Created by Yudis Huang on 19/10/21.
//

import Foundation

struct ResultsResponse : Codable {
    let data : [Results]
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct Results : Codable {
    var name : String
    var subtypes : [String]
    var types : [String]
    var flavorText : String!
    var images : Size!
    var hp : String!
    
}

struct Size : Codable {
    var small : String!
}





