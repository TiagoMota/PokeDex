//
//  ViewController.swift
//  PokeDex
//
//  Created by Tiago Mota on 09/03/16.
//  Copyright © 2016 tiagomota.eu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var pokedex = [Pokemon]()
    private var filteredPokedex = [Pokemon]()
    private var musicPlayer : AVAudioPlayer?
    private var isSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = UIReturnKeyType.Done
        
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        //view.addGestureRecognizer(tap)
        
        loadPokedex()
        
        loadMusic()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func loadPokedex() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            
            for row in csv.rows {
                let pokemon = Pokemon(name: row["identifier"]!, pokeId: Int(row["id"]!)!)
                self.pokedex.append(pokemon)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func loadMusic() {
        let path = NSURL(string: NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!)!
        do {
            self.musicPlayer = try AVAudioPlayer(contentsOfURL: path)
            self.musicPlayer?.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func pressedMusicBtn(sender: UIButton) {
        if self.musicPlayer!.playing {
            self.musicPlayer!.stop()
            sender.alpha = 0.2
        } else {
            self.musicPlayer!.play()
            sender.alpha = 1.0
        }
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearchMode = false
            dismissKeyboard()
        } else {
            isSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredPokedex = pokedex.filter({
                $0.name.rangeOfString(lower) != nil
            })
        }
        
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeDexCell", forIndexPath: indexPath) as? PokeDexCell {
            
            var pokemon : Pokemon
            
            if isSearchMode {
                pokemon = filteredPokedex[indexPath.row]
            } else {
                pokemon = pokedex[indexPath.row]
            }
            
            cell.configureCell(pokemon)
            
            return cell
        } else {
            // in case of error return empty cell
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        var pokemon : Pokemon
        
        if isSearchMode {
            pokemon = filteredPokedex[indexPath.row]
        } else {
            pokemon = pokedex[indexPath.row]
        }

        performSegueWithIdentifier("PokemonDetail", sender: pokemon)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isSearchMode {
            return filteredPokedex.count
        }
        
        return pokedex.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        // just one section for now
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetail" {
            if let dest = segue.destinationViewController as? PokemonDetailViewController {
                if let pokemon = sender as? Pokemon {
                    dest.pokemon = pokemon
                }
            }
        }
    }
}

