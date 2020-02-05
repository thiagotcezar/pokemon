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
        
        // Setando o name da Navigation c/ nome do Pokemon
        let poke = pokemon!
        self.title = (poke.name).uppercased()
        
        // Setando o nome do back button da navigation bar
        self.navigationController?.navigationBar.topItem?.title = "Back"
        
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch section {
            
        case 0:
            
            return 1
        
        case 1:
            
            return 1
            
        case 2:
            
            return pokemon?.moves.count ?? 0
            
        default:
            
            return 0
        }
        
//        if section == 0{
//
//            return 1
//
//        }else{
//
//            return pokemon?.moves.count ?? 0
//
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        // Setando as var's para as duas Cell's
        let PokemonAbiliityCell = "PokemonAbiliityCell"
        let PokemonCell = "PokemonCell"
        
        if let PokemonCell = tableView.dequeueReusableCell(withIdentifier: PokemonCell, for: indexPath) as? PokemonCell{
            if let PokemonAbiliityCell = tableView.dequeueReusableCell(withIdentifier: PokemonAbiliityCell, for: indexPath) as? PokemonAbiliityCell {
                
                
                switch indexPath.section {
                    
                case 0:
                    
                    // Seta a imagem do pokemon
                    let url = URL(string: (pokemon?.sprites.imageUrl)!)
                    PokemonCell.pokemonImage.load(url: url!)
                    
                    // Seta a imagem back do Pokemon
                    
                    // seta o tipo do pokemon
                    let pokeType = pokemon?.types[indexPath.item]
                    PokemonCell.setType(type: pokeType!)
                    
                    // Seta o ID do Pokemon
                    let poke = pokemon!
                    PokemonCell.idLabel.text = "# \(poke.id)"
                    
                    // preenche a primeira celula com imagem, nome e tipo
                    return PokemonCell
                    
                case 1:
                    
                    let titleCell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) 
                    
                    
                    return titleCell
                    
                case 2:
                    
                    // Seta as habilidades
                    let pokeMove = pokemon?.moves[indexPath.row]
                    PokemonAbiliityCell.setData(move: pokeMove!)
                    return PokemonAbiliityCell
                    
                default:
                    
                    return UITableViewCell()
                }
            
        
//            if indexPath.section == 0{
//
//                // Seta a imagem do pokemon
//                let url = URL(string: (pokemon?.sprites.imageUrl)!)
//                PokemonCell.pokemonImage.load(url: url!)
//
//                // Seta o nome do pokemon
//                let poke = pokemon!
//                PokemonCell.nameLabel.text = (poke.name).capitalized
//
//                // seta o tipo do pokemon
//                let pokeType = pokemon?.types[indexPath.item]
//                PokemonCell.setType(type: pokeType!)
//
//                // preencha a primeira celula com imagem, nome e tipo
//                return PokemonCell
//
//            }else{
//
//                // Seta as habilidades
//                let pokeMove = pokemon?.moves[indexPath.row]
//                PokemonAbiliityCell.setData(move: pokeMove!)
//                return PokemonAbiliityCell
//
//                    }
            
            
                }
            }
        return UITableViewCell()
        }
    }

