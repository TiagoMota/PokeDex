//
//  PokeDexCell.swift
//  PokeDex
//
//  Created by Tiago Mota on 09/03/16.
//  Copyright © 2016 tiagomota.eu. All rights reserved.
//

import Nuke
import UIKit

class PokeDexCell: UICollectionViewCell {

    @IBOutlet weak var _thumbImg : UIImageView!
    @IBOutlet weak var _nameLabel : UILabel!
    
    private var _pokemon: Pokemon!
    
    var pokemon : Pokemon {
        return self._pokemon
    }
    
    var thumbImg : UIImageView {
        return self._thumbImg
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0
    }
    
    
    func configureCell (pokemon: Pokemon) {
        self._pokemon = pokemon
        
        // set pokemon name
        self._nameLabel.text = pokemon.name.capitalizedString
        
        // set pokemon image thumbnail by loading the image with Nuke
        
        self._thumbImg.image = UIImage(named: "\(self._pokemon.pokeId!)")
    }
}
