//
//  PokemonViewModel.swift
//  poketmonApp2
//
//  Created by 최영건 on 5/15/25.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation

class PokemonViewModel {
    private let disposeBag = DisposeBag()
    private let pageSize = 20
    private var currentOffset = 0
    private var isLoadingNextPage = false
    
    let pokemonDetails: BehaviorRelay<[PokemonDetail]> = .init(value: [])
    
    func loadPokemons() {
        guard !isLoadingNextPage else { return }
        isLoadingNextPage = true
        
        PokemonAPIData.shared.fetchPokemonsList(limit: pageSize, offset: currentOffset)
            .flatMap { entries -> Observable<[PokemonDetail]> in
                let ids = entries.compactMap {
                    Int($0.url.split(separator: "/").last ?? "")
                }
                let requests = ids.map { PokemonAPIData.shared.fetchPokemonDetail(id: $0) }
                return Observable.zip(requests)
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] details in
                guard let self = self else { return }
                self.pokemonDetails.accept(self.pokemonDetails.value + details)
                self.currentOffset += self.pageSize
                self.isLoadingNextPage = false
            }, onError: { error in
                print("에러 발생 \(error)")
                self.isLoadingNextPage = false
            }).disposed(by: disposeBag)
    }
}
