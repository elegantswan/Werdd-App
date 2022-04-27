//
//  WordModel.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/18/22.
//

import UIKit

struct Word: Codable {
    let word: String
    let results: [WordDetail]?
}

struct WordDetail: Codable {
    let definition: String?
    let partOfSpeech: String?
    let synonyms: [String]?
    let antonyms: [String]?
    let examples: [String]?
}

