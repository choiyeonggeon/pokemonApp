//
//  MainViewModel.swift
//  poketmonApp2
//
//  Created by 최영건 on 5/13/25.
//

import UIKit
import RxSwift
import Foundation

class MainViewModel {
  
    private let disposeBag = DisposeBag()
    
    // View가 구독할 Subject.
    let pokemonListSubject = BehaviorSubject(value: [PokemonAPIData]())
    let pokemonModelSubject = BehaviorSubject(value: [PokemonAPIData]())
    let pokemonAPISubject = BehaviorSubject(value: [PokemonAPIData]())
    let pokemonDetailSubject = PublishSubject<PokemonDetail>()


    
    init() {
        fetchPokemonList()
        fetchPokemonAPI()

    }
    
    func fetchPokemonList() {
        
    }
    
    func fetchPokemonAPI() {
        
    }
    
    func loadNextPage() {
        
    }
    
    func pokemonDetails() {
        
    }
}
