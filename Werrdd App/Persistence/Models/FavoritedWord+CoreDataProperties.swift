//
//  FavoritedWord+CoreDataProperties.swift
//  Werrdd App
//
//  Created by Kevin Phan on 5/4/22.
//
//

import Foundation
import CoreData


extension FavoritedWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritedWord> {
        return NSFetchRequest<FavoritedWord>(entityName: "FavoritedWord")
    }

    @NSManaged public var synonyms: [String]?
    @NSManaged public var examples: [String]?
    @NSManaged public var antonyms: [String]?
    @NSManaged public var definition: String?
    @NSManaged public var partOfSpeech: String?
    @NSManaged public var word: String?

}

extension FavoritedWord : Identifiable {

}
