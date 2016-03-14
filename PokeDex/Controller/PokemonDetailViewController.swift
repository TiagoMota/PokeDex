//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Tiago Mota on 13/03/16.
//  Copyright © 2016 tiagomota.eu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokeIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    @IBOutlet weak var secondEvolImg: UIImageView!
    @IBOutlet weak var thirdEvoLbl: UIImageView!
    
    var pokemon : Pokemon!
    
    override func viewDidLoad() {
        self.nameLbl.text = "\(pokemon.name.capitalizedString)"
        self.mainImg.image = UIImage(named: "\(self.pokemon.pokeId)")
    
        loadPokemon()
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func loadPokemon() {
        let URL = "\(Constants.URL_POKEMON)\(self.pokemon.pokeId)"
        print(URL)
        Alamofire.request(.GET, URL).responseObject { (response: Response<Pokemon, NSError>) in
            
            if let poke = response.result.value {
                poke.pokeId = self.pokemon.pokeId
                self.pokemon = poke
                
                self.loadPokemonDescription()
                
                self.updateUI()
            }
        }
    }
    
    func loadPokemonDescription() {
        let DESC_URL = "\(Constants.URL_BASE)\(self.pokemon.descriptions[0].url)"
        Alamofire.request(.GET, DESC_URL).responseJSON { response in
            if let JSON = response.result.value as? Dictionary<String,AnyObject> {
                self.pokemon.description = (JSON["description"] as! String)
                self.updateUI()
            }
        }

    }
    
    func updateUI() {
        var types : String = ""
        for type in self.pokemon.types {
            if types == "" {
                types = "\(type.name.capitalizedString)"
            } else {
                types = "\(types) / \(type.name.capitalizedString)"
            }
        }
        self.typeLbl.text = types
        
        self.pokeIdLbl.text = "\(self.pokemon.pokeId)"
        //self.attackLbl.text = self.pokemon.attack
        //self.defLbl.text = self.pokemon.defense
        self.heightLbl.text = self.pokemon.height
        self.weightLbl.text = self.pokemon.weight
        if let desc = self.pokemon.description {
            self.descriptionLbl.text = desc
        }
    }
}
