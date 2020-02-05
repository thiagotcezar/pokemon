//
//  PokemonAbiliityCell.swift
//  Pokemon
//
//  Created by K2 - Thiago Cézar on 27/01/20.
//  Copyright © 2020 Thiago Cézar. All rights reserved.
//

import UIKit

class PokemonAbiliityCell: UITableViewCell {
    
    @IBOutlet weak var abilityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(move: Move){
        self.abilityLabel.text = move.ability.name.capitalized
    }
    

}
