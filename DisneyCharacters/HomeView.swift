//
//  HomeView.swift
//  DisneyCharacters
//
//  Created by João Pedro C. D'Agnoluzzo on 25/07/24.
//

import UIKit

final class HomeView: UIView {
    
    //MARK: Properties
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    //MARK: Setup
    func setupView() {
        self.backgroundColor = UIColor.orange
        createSubViews()
    }
    
    func createSubViews() {
        addSubview(imageView)
        setupImageViewConstraints()
    }
    
    func setupImageViewConstraints() {
        let offset: CGFloat = 30.0
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant:offset),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: offset),
            imageView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant:-offset),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -offset)
        ])
    }
}
