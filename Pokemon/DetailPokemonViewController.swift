//
//  DetailPokemonViewController.swift
//  Pokemon
//
//  Created by K2 - Thiago Cézar on 27/01/20.
//  Copyright © 2020 Thiago Cézar. All rights reserved.
//

import UIKit

class DetailPokemonViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var pokemon: PokemonElement?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        //print(pokemon?.name)
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailPokemonViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            
            return 1
            
        }else{
            
            return pokemon?.moves.count ?? 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let PokemonAbiliityCell = "PokemonAbiliityCell"
        let PokemonCell = "PokemonCell"
        
        if let celula = tableView.dequeueReusableCell(withIdentifier: PokemonAbiliityCell, for: indexPath) as? PokemonAbiliityCell {
        if let celula1 = tableView.dequeueReusableCell(withIdentifier: PokemonCell, for: indexPath) as? PokemonCell{
            
            
            if indexPath.section == 0{
                
                // Seta a imagem
                let url = URL(string: (pokemon?.sprites.imageUrl)!)
                celula1.pokemonImage.load(url: url!)
                
                // Seta o nome
                let poke = pokemon!
                celula1.nameLabel.text = poke.name
                
                let pokeType = pokemon?.types[indexPath.row]
                celula1.setType(type: pokeType!)
                            
                // preencha a primeira celula com imagem, nome e tipo
                return celula1
               
                
            }else{
                
                let pokeMove = pokemon?.moves[indexPath.row]
                celula.setData(move: pokeMove!)
                return celula
        
            
                    }
                        
                }
            
            }
        
        return UITableViewCell()
        
        }
    
    }


