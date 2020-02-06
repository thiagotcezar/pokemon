//
//  ViewController.swift
//  Pokemon
//
//  Created by K2 - Thiago Cézar on 13/01/20.
//  Copyright © 2020 Thiago Cézar. All rights reserved.
//

import UIKit

class ListPokemonViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Outlet com a UICollectionView (Após clicar no Storyboard, arrasta segurando o control para criar o Outlet)
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Passando a Model com os "contratos" para a variável
    var pokemons: [PokemonElement] = []
    
    var filteredData: [PokemonElement] = []
    
    var hasSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        filteredData = pokemons
        //        // Adicionado refresh na Navigation Bar
        //        let addButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(accessibilityPerformMagicTap))
        //        self.navigationItem.rightBarButtonItem = addButton
        
        fetchPokemon()
        
    }
    
    func fetchPokemon(){
        var count = 1
        
        for i in count...count + 150 {
            
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
        
        count = count + 150
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if hasSearch{
            //if let pokemon = self.filteredData{
            return filteredData.count
            //}else{
            //  return 0
            //}
            
        }else{
            return pokemons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        if hasSearch{
            
            let poke = filteredData[indexPath.item]
            
            cell.namePokemon.text = (poke.name).capitalized
            cell.imagePokemon.image = nil
            let url = URL(string: poke.sprites.imageUrl)
            cell.imagePokemon.load(url: url!)
            
            return cell
            
        }else{
            
            let poke = pokemons[indexPath.item]
            
            cell.namePokemon.text = (poke.name).capitalized
            cell.imagePokemon.image = nil
            let url = URL(string: poke.sprites.imageUrl)
            cell.imagePokemon.load(url: url!)
            
            return cell
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print(segue.identifier) - Printa as habilidades do Pokemon escolhido
        
        if let detailViewController = segue.destination  as? DetailPokemonViewController {
            if let pokemon = sender as? PokemonElement{
                detailViewController.pokemon = pokemon
                self.navigationController?.navigationBar.topItem?.title = "Back"
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if hasSearch{
            
            let poke = filteredData[indexPath.row]
            //print(poke.name)
            self.performSegue(withIdentifier: "seguePokemon", sender: poke)
            
        }else{
            
            let poke = pokemons[indexPath.row]
            //print(poke.name)
            self.performSegue(withIdentifier: "seguePokemon", sender: poke)
            
        }
    }
}


extension ListPokemonViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = self.view.bounds.width
        let cellW = w / 3 - 12
        return CGSize(width: cellW, height: cellW)
    }
    
}

extension ListPokemonViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count > 0 {
            hasSearch = true
            filteredData = pokemons.filter({$0.name.uppercased().contains(searchText.uppercased())})
            print(filteredData)
        }else {
            
            hasSearch = false
        }
        
        self.collectionView.reloadData()
        
        
    }
    
}



