//
//  ViewController.swift
//  PokeDex
//
//  Created by Tiago Mota on 09/03/16.
//  Copyright © 2016 tiagomota.eu. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var _collectionView: UICollectionView!
    
    private var _pokedex = [Int : Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._collectionView.delegate = self
        self._collectionView.dataSource = self
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeDexCell", forIndexPath: indexPath) as? PokeDexCell {
            
            if let pokemon = self._pokedex[indexPath.row + 1] {
                cell.configureCell(pokemon)
            } else {
                
                cell.showLoading()
                
                let URL = "\(Constants.URL_POKEMON)\(indexPath.row + 1)"
                debugPrint("Cell request URL -> \(URL)")
                
                Alamofire.request(.GET, URL).responseObject { (response: Response<Pokemon, NSError>) -> Void in
                    
                    if let error = response.result.error {
                        cell.showError(error)
                    } else {
                        let pokemon = response.result.value!
                        pokemon.pokeId = indexPath.row + 1
                        self._pokedex[pokemon.pokeId!] = pokemon
                        
                        cell.configureCell(pokemon)
                    }
                }
            }
            
            return cell
        } else {
            // in case of error return empty cell
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if let pokeCell = cell as? PokeDexCell {
            pokeCell.stop()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // when item is selected
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 718
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        // just one section for now
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 110, height: 110)
    }
}

