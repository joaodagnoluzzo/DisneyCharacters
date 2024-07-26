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
    
    func fetchCharactersAsync(completion: @escaping (Result<CharactersResult, Error>) -> Void) {
        let requestHttp = "\(baseUrl)/character"
        guard let requestUrl = URL(string: requestHttp) else { return }
        
        self.session.dataTask(with: requestUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(self.decodeCharacters(data:data)))
            }
        }.resume()
        
    }
    
    func fetchCharactersSync() -> [DisneyCharacter] {
        var result = CharactersResult()
        let requestHttp = "\(baseUrl)/character"
        
        guard let requestUrl = URL(string: requestHttp) else { return [] }
        
        var data: Data?
        let semaphore = DispatchSemaphore(value: 0)
        
        self.session.dataTask(with: requestUrl) { resultData, response, resultError in
            data = resultData
            
            semaphore.signal()
        }.resume()
        
        semaphore.wait()
        
        if let data = data {
            result = self.decodeCharacters(data: data)
        }
        
        return result.data
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
    
    func fetchCharacterImageData(url: URL, completion: @escaping (Data?) -> Void) {
        self.session.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            completion(data)
            
        }.resume()
    }
    
    
}

