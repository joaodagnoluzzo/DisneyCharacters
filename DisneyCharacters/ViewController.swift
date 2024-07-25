//
//  ViewController.swift
//  DisneyCharacters
//
//  Created by João Pedro C. D'Agnoluzzo on 24/07/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor.cyan
        
        let charactersApi = CharactersAPI()
        charactersApi.fetchCharacters { response in
            switch response {
            case .success(let result):
                if result.data.isEmpty {
                    print("No results")
                } else {
                    let charactersList = result.data
                    charactersList.forEach({ character in
                        print("\(character.name): \(character.imageUrl ?? "Empty url")")
                    })
                }
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
        
    }


}

