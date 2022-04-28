//
//  NetworkManager.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/19/22.
//

import Foundation
import UIKit

enum Error: LocalizedError {
    case invalidURL
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidData:
            return "Invalid Data"
        }
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchRandomWord(completion: @escaping (Result<Word, Error>) -> Void) {
        
        guard let url = URL(string: Constants.randomBaseURL) else {
            completion(.failure(Error.invalidURL))
            return
        }
        
        let headers = [
            "X-RapidAPI-Host": Constants.hostURL,
            "X-RapidAPI-Key": Constants.weatherApiKey
        ]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.invalidURL))
                return
            }
            
            do {
                let randomWord = try JSONDecoder().decode(Word.self, from: data)
                completion(.success(randomWord))
            } catch {
                completion(.failure(Error.invalidData))
            }
        }.resume()
    }
    
    func fetchWord(word: String, completion: @escaping (Result<Word, Error>) -> Void) {
        
        guard let endpoint = URL(string: Constants.baseURL + word) else {
            completion(.failure(Error.invalidURL))
            return
        }

        let headers = [
            "X-RapidAPI-Host": Constants.hostURL,
            "X-RapidAPI-Key": Constants.weatherApiKey
        ]
        
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let specificWord = try JSONDecoder().decode(Word.self, from: data)
                completion(.success(specificWord))
            } catch {
                print("Network Call Failed😞")
            }
        }.resume()
    }
}


