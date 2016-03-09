//
//  ViewController.swift
//  PokeDex
//
//  Created by Tiago Mota on 09/03/16.
//  Copyright © 2016 tiagomota.eu. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let URL = "\(Constants.URL_POKEMON)1"
        Alamofire.request(.GET, URL).responseObject { (response: Response<Pokemon, NSError>) -> Void in
            
            let pokemon = response.result.value
            print(pokemon?.name)
        }
    }
}

