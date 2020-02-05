//
//  PokemonCell.swift
//  Pokemon
//
//  Created by K2 - Thiago Cézar on 27/01/20.
//  Copyright © 2020 Thiago Cézar. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var pokemonImageBack: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setType(type: Types){
        self.typeLabel.text = type.type.name.capitalized
    }
    
    

}
