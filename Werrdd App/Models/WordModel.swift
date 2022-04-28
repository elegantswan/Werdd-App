//
//  WordModel.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/18/22.
//

import UIKit


struct WordDataSource {
    let words = [
        tempWord(name: "antelope chipmunk",
             definition: "small ground squirrel of western United States",
             partOfSpeech: "noun",
             synonyms: ["whitetail antelope squirrel", "Citellus leucurus"],
             antonyms: nil,
             examples: ["I saw an antelope chipmunk in my backyard"]
        ),
        tempWord(
            name: "auricular artery",
            definition: "artery that supplies blood to the ear",
            partOfSpeech: "noun",
            synonyms: ["arteria auricularis"],
            antonyms: nil,
            examples: ["todd's ears are red because of his auricular artery"]
        ),
        tempWord(
            name: "electric circuit",
            definition: "an electrical device that provides a path for electrical current to flow",
            partOfSpeech: "noun",
            synonyms: ["circuit"],
            antonyms: nil,
            examples: ["The superhero, Static Shock, has power over electric circuits", "without electric circuits, we wouldn't have battery power for our Macbooks"]
        ),
        tempWord(
            name: "punic",
            definition: "of or relating to or characteristic of ancient Carthage or its people or their language",
            partOfSpeech: "adjective",
            synonyms: ["Carthaginian"],
            antonyms: nil,
            examples: ["The Carthaginian Empire was throughout North Africa and modern Spain from 575 B.C.E until 146 B.C.E."]
        ),
        tempWord(
            name: "glib",
            definition: "artfully persuasive in speech",
            partOfSpeech: "adjective",
            synonyms: ["artful, articulate, eloquent, facile, loquacious, talkative"],
            antonyms: ["quiet", "silent", "inarticulate", "tongue-tied", "stuttering", "uncommunicative"],
            examples: ["I don’t want to sound too glib here—there’s still privilege inherent in my situation.", "Glib talk often commands an undeserved confidence and misleads the wage earner."]
        ),
        tempWord(
            name: "appetite",
            definition: "a feeling of craving something",
            partOfSpeech: "noun",
            synonyms: ["craving", "demand", "fondness", "greed", "hunger", "passion", "yearning"],
            antonyms: ["apathy", "disclination", "dislike", "indifference", "lethargy"],
            examples: ["When taste diminishes, with age or after treatments such as chemotherapy, people can lose their appetites and become malnourished."]
        ),
        tempWord(
            name: "authoritatively",
            definition: "in an authoritative and magisterial manner",
            partOfSpeech: "adverb",
            synonyms: ["approvedly"],
            antonyms: ["casually", "informally", "uncermoniously"],
            examples: ["This is because Google wants the authoritative product information that manufacturers are able to provide.", "With hundreds of episodes and new series offering exclusive access to kitchens around the world, rich cultures, immersive experiences, and authoritative experts, Eater’s got you covered."]
        ),
        tempWord(
            name: "golf links",
            definition: "a golf course that is built on sandy ground near a shore",
            partOfSpeech: "noun",
            synonyms: nil,
            antonyms: nil,
            examples: nil
        ),
        tempWord(
            name: "unsay",
            definition: "take back what one has said",
            partOfSpeech: "verb",
            synonyms: ["cancel", "dismiss", "withdraw"],
            antonyms: ["allow", "permit", "restore"],
            examples: ["Naomi regretted her words next moment; but it was too late to unsay them", "I have to unsay everything I said in criticism of that lovely poem."]
        ),
        tempWord(
            name: "unbarreled",
            definition: "not in a barrel",
            partOfSpeech: "adjective",
            synonyms: nil,
            antonyms: ["barreled"], examples: ["I was once in a barrel but then was unbarreled."]
        )
    ]
}

struct tempWord {
    let name: String
    let definition: String
    let partOfSpeech: String
    
    let synonyms: [String]?
    let antonyms: [String]?
    let examples: [String]?
}

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

