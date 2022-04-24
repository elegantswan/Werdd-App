//
//  RESTHelper.swift
//  Werrdd App
//
//  Created by Kevin Phan on 4/22/22.
//

import Foundation

class RESTHelper {
    
     static func fetchWord<T: Decodable>(url: String, completion: @escaping (T, NSError?) -> ()){
        
        let url = URL(string: url)
                
        URLSession.shared.dataTask(with: url!){(data,  response, err) in
            
            guard let data = data else {return}
            
            do {
                print("JSON RESPONSE: \(String(data: data, encoding: .utf8)!)")
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj, err as NSError?)
                
            } catch let jsonErr{
                print("Failed to decode json:", jsonErr)
            }
        }.resume()
    }
}
