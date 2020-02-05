//
//  PokemonProvider.swift
//  Pokemon
//
//  Created by K2 - Thiago Cézar on 22/01/20.
//  Copyright © 2020 Thiago Cézar. All rights reserved.
//

import Foundation
import Alamofire

public enum Result<T>: Equatable {
    case success(T)
    case failure
    public static func == (lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
            case (.failure, .failure), (.success, .success):
                return true
            default:
                return false
        }
    }
}

class RequestGet{
    
    func fetchData(url: String, completion: @escaping (Result<PokemonElement>) -> Void) {
        Alamofire.request(url).responseJSON { (response) in
            switch(response.result) {
            case let .success(data):
                let decoder = JSONDecoder()
                do {
                    let records = try decoder.decode(PokemonElement.self, from: response.data!)
                    completion(.success(records))
                } catch let error {
                    print(error)
                    completion(.failure)
                }
            case let .failure(_):
                completion(.failure)
            }
        }
        
    }
               
}


