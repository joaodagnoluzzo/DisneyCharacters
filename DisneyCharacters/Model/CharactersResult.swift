//
//  CharactersResult.swift
//  DisneyCharacters
//
//  Created by João Pedro C. D'Agnoluzzo on 24/07/24.
//

import Foundation

struct CharactersResult: Decodable {
    let info: PageInfo
    let data: [DisneyCharacter]
    
    init() {
        info = PageInfo()
        data = []
    }
}

struct PageInfo: Decodable {
    let count: Int
    let totalPages: Int
    let previousPage: String?
    let nextPage: String
    
    init() {
        count = 0
        totalPages = 0
        previousPage = ""
        nextPage = ""
    }
}

struct DisneyCharacter: Decodable {
    let _id: Int
    let films: [String]
    let name: String
    let imageUrl: String?
    let url: String
}
