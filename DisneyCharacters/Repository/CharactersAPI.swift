//
//  CharactersAPI.swift
//  DisneyCharacters
//
//  Created by João Pedro C. D'Agnoluzzo on 24/07/24.
//

import Foundation


final class CharactersAPI {
    
    private let baseUrl = "https://api.disneyapi.dev"
    private let session = URLSession.shared
    
    func fetchCharacters(completion: @escaping (Result<CharactersResult, Error>) -> Void) {
        
        let requestHttp = "\(baseUrl)/character"
        print(requestHttp)
        guard let requestUrl = URL(string: requestHttp) else { return }
        
        let aux = self.session.dataTask(with: requestUrl) { data, response, error in
            
        }
        
        aux.resume()
        
        let task = self.session.dataTask(with: requestUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(self.decodeCharacters(data:data)))
            }
        }
        task.resume()
        
    }
    
    private func decodeCharacters(data: Data) -> CharactersResult {
        var result = CharactersResult()
        do {
            let decodedData = try JSONDecoder().decode(CharactersResult.self, from:data)
            result = decodedData
        } catch {
            print("JSON Decoding Error: \(error)")
        }
        return result;
    }
    
    
}

