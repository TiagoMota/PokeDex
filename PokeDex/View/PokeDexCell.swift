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
    
    func configureCell (pokemon: Pokemon) {
        self._pokemon = pokemon
        
        let url = "\(Constants.URL_POKEMON_IMG)\( self._pokemon.pokeId).png"
        var request = ImageRequest(URLRequest: NSURLRequest(URL: NSURL(string: url)!))
        request.priority = NSURLSessionTaskPriorityHigh
        
        Nuke.taskWith(request) {
            // - Image is resized to fill target size
            // - Blur filter is applied
            self._thumbImg.image = $0.image
            }.resume()
    }
}
