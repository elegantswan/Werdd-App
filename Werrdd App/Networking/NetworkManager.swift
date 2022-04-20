//
//  NetworkManager.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/19/22.
//

import UIKit

class NetworkManager {
    
    public func fetchWord(completion: @escaping (Word, Error) -> Void) {
        
        guard let wordURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words/example") else {
            print("Invalid URL")
            return
        }
        
        let headers = [
            "X-RapidAPI-Host": "wordsapiv1.p.rapidapi.com",
            "X-RapidAPI-Key": "14acfc5fe1msh8077fb299df28a6p169026jsna0fbc48d995b"
        ]
        
        var urlRequest = URLRequest(url: wordURL)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let word = try JSONDecoder().decode(Word.self, from: data)
                print(word)
            } catch {
                print("Network Call Failed😞")
            }
        }.resume()
    }
}


