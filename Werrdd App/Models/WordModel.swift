//
//  WordModel.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/18/22.
//

import UIKit

struct Word: Codable {
    let word: String
    let results: [Result]
    let syllables: Syllables
}

struct Result: Codable {
    let definition, partOfSpeech: String
    let synonyms, typeOf: [String]
}

struct Syllables: Codable {
    let count: Int
    let list: [String]
}
