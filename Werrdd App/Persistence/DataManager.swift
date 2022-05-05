//
//  DataManager.swift
//  Werrdd App
//
//  Created by Kevin Phan on 5/3/22.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()


    //MARK: - Create
    static func saveWord(word: String, definition: String, partOfSpeech: String?, synonyms: [String]?, antonyms: [String]?, examples: [String]?) {
        
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        let favoritedWord = FavoritedWord(context: managedObjectContext)
        favoritedWord.word = word
        favoritedWord.definition = definition
        favoritedWord.partOfSpeech = partOfSpeech
        favoritedWord.synonyms = synonyms
        favoritedWord.antonyms = antonyms
        favoritedWord.examples = examples
        
        do {
            try managedObjectContext.save()
        } catch {
            print("DUPLICATE!!")
        }
    }
    
    //MARK: - Read
    static func fetchFavoritedWords(completion: ([FavoritedWord]?) -> Void) {
        
        do {
            let favoritedItems = try managedObjectContext.fetch(FavoritedWord.fetchRequest())
            completion(favoritedItems)
        } catch {
            print("Error occured while fetching favorited words.")
        }
        completion(nil)
    }
        
    //MARK: - Delete
    static func deleteWord(word: FavoritedWord) {
        
        managedObjectContext.delete(word)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Something went wrong when deleting word.")
        }
    }
}
