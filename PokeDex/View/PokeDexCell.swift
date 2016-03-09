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
    @IBOutlet weak var _progressView : UIActivityIndicatorView!
    
    private var _pokemon: Pokemon!
    
    var pokemon : Pokemon {
        return self._pokemon
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
        let url = "\(Constants.URL_POKEMON_IMG)\( self._pokemon.pokeId).png"
        var request = ImageRequest(URLRequest: NSURLRequest(URL: NSURL(string: url)!))
        request.priority = NSURLSessionTaskPriorityHigh
        
        Nuke.taskWith(request) {
            // hide progress view
            self._progressView.stopAnimating()
            
            // set and show pokemon image
            self._thumbImg.image = $0.image
            self._thumbImg.hidden = false
            
            }.resume()
    }
    
    
    func showError(error: NSError) {
        self._nameLabel.text = "ERROR!"
        print("Error loading pokemon: \(error.code) - \(error.description)")
    }
    
    func showLoading() {
        // hide image view
        self._thumbImg.hidden = true
        
        // show progress view
        self._progressView.hidesWhenStopped = true
        self._progressView.startAnimating()
    }
}
