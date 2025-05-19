//
//  MainViewController.swift
//  poketmonApp2
//
//  Created by 최영건 on 5/13/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PokemonViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width: CGFloat = (UIScreen.main.bounds.width - spacing * 4) / 3
        layout.itemSize = CGSize(width: width, height: width + 30)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindCollectionView()
        viewModel.loadNextPage()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    private func bindCollectionView() {
        viewModel.pokemonDetails
            .drive(collectionView.rx.items(
                cellIdentifier: "PokemonCell",
                cellType: PokemonCell.self
            )) { index, model, cell in
                cell.configure(with: model)
            }.disposed(by: disposeBag)
        
        
        collectionView.rx.contentOffset
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] offset in
                guard let self = self else { return }
                let contentHeight = self.collectionView.contentSize.height
                let scrollViewHeight = self.collectionView.frame.size.height
                let offsetY = offset.y
                
                if offsetY > contentHeight - scrollViewHeight - 100 {
                    
                    self.viewModel.loadNextPage()
                }
            }).disposed(by: disposeBag)
    }
}

