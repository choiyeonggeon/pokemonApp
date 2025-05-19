//
//  PokemonCell.swift
//  poketmonApp2
//
//  Created by 최영건 on 5/15/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class PokemonCell: UICollectionViewCell {
    static let reuseIdentifier = "PokemonCell"
    
    private let nameLabel = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemYellow.withAlphaComponent(0.3)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configure(with pokemon: PokemonDetail) {
        nameLabel.text = pokemon.name.capitalized
       
        if let imageUrlString = pokemon.sprites.frontDefault,
        let imageUrl = URL(string: imageUrlString) {
            imageView.kf.setImage(with: imageUrl)
    
        }
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let data = data {
//                    DispatchQueue.main.async {
//                        self.imageView.image = UIImage(data: data)
//                    }
//                }
//            }.resume()
            
        }
    }

