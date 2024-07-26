//
//  HomeViewController.swift
//  DisneyCharacters
//
//  Created by João Pedro C. D'Agnoluzzo on 24/07/24.
//

import UIKit

class HomeViewController: UIViewController {

    private lazy var customView: HomeView = {
        return HomeView()
    }()
    
    private lazy var charactersApi: CharactersAPI = {
        return CharactersAPI()
    }()
    
    private var charactersList: [DisneyCharacter] = []
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.charactersList = charactersApi.fetchCharactersSync()
        if !charactersList.isEmpty {
            loadImage(url: charactersList[0].imageUrl)
        }
    }
    
    func loadCharactersListAsync() {
        charactersApi.fetchCharactersAsync { [weak self] response in
            switch response {
            case .success(let result):
                self?.charactersList = result.data
                print("Characters count: \(result.data.count)")
            case .failure(let error):
                print("Error: \(error)")
                self?.charactersList = []
            }
        }
    }
    
    func loadImage(url: String?) {
        guard let url = url, let imageUrl = URL(string: url) else { return }
        charactersApi.fetchCharacterImageData(url: imageUrl) { data in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.customView.imageView.image = image
                self.customView.imageView.backgroundColor = .brown
            }
        }
    }

}

