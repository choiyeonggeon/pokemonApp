//
//  PoketmonData.swift
//  poketmonApp2
//
//  Created by 최영건 on 5/14/25.
//

import RxSwift
import RxCocoa
import Foundation

class PokemonAPIData {
    
    static let shared = PokemonAPIData()
    private let disposeBag = DisposeBag()
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    private let pokemonDetailSubject = BehaviorSubject<[PokemonEntry]>(value: [])
    private let pokemonListSubject = BehaviorSubject<[PokemonEntry]>(value: [])
    private let pokemonDetails = BehaviorRelay<[PokemonDetail]>(value: [])
    
    var pokemonList: Observable<[PokemonEntry]> {
        return pokemonListSubject.asObservable()
    }
        
        
        func fetchPokemonsList(limit: Int = 20, offset: Int = 0) -> Observable<[PokemonEntry]> {
            let urlString = "\(baseURL)/pokemon?limit=\(limit)&offset=\(offset)"
            guard let url = URL(string: urlString) else {
                return Observable.error(NetworkError.dataFetchFail)
                
            }
            
            NetworkManager.shared.fetch(url: url)
                .subscribe(onSuccess: { [weak self] (pokemonResponse: PokemonListResponse) in
                    self?.pokemonListSubject.onNext(pokemonResponse.results)
                }, onFailure: { [weak self] error in
                    self?.pokemonListSubject.onError(error)
                }).disposed(by: disposeBag)
            return Disposables.create() as! Observable<[PokemonEntry]>
        }
        
        func fetchPokemonDetail(id: Int) -> Observable<PokemonDetail> {
            let urlString = "\(baseURL)/pokemon/\(id)"
            guard let url = URL(string: urlString) else {
                return Observable.error(NetworkError.dataFetchFail)
            }
            
            NetworkManager.shared.fetch(url: url)
                .subscribe(onSuccess: { [weak self] (detail: PokemonDetailResponse) in
                    self?.pokemonDetailSubject.onNext(detail.results)
                }, onFailure: { [weak self] error in
                    self?.pokemonDetailSubject.onError(error)
                }).disposed(by: disposeBag)
            return Disposables.create() as! Observable<PokemonDetail>
        }
    }
    
