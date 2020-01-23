//
//  ViewController.swift
//  Pokemon
//
//  Created by K2 - Thiago Cézar on 13/01/20.
//  Copyright © 2020 Thiago Cézar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
     
    // Outlet com a UICollectionView (Após clicar no Storyboard, arrasta segurando o control para criar o Outlet)
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Passando a Model com os "contratos" para a variável
    var pokemons: [PokemonElement] = []
                                              
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let addButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(accessibilityPerformMagicTap))
        self.navigationItem.rightBarButtonItem = addButton
        
        fetchPokemon()
        
    }
    
    func fetchPokemon(){
        var count = 1
        
        for i in count...count + 50 {

            let request = RequestGet()
            request.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(i)") { (result) in
                switch(result) {
                case let.success(pokemon):
                    
                    // Adiciona os itens da API na Collection View
                    self.pokemons.append(pokemon)
                    
                    // Exibi os itens a partir do Index 0
                    self.pokemons.sort { $0.id < $1.id }
                    
                    // Atualiza a collection View
                    self.collectionView.reloadData()
                    case.failure:
                    print("erro")
                
                }
            }
            
        }
        
        count = count + 50
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let poke = pokemons[indexPath.item]
        cell.namePokemon.text = poke.name
        //print(poke.moves)
        //print(poke.types)
        let url = URL(string: poke.sprites.imageUrl)
            cell.imagePokemon.load(url: url!)

            return cell
        
    }
    
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = self.view.bounds.width
        let cellW = w / 3 - 10
        return CGSize(width: cellW, height: cellW)
    }
    
}



