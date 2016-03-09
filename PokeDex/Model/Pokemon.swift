//
//  File.swift
//  PokeDex
//
//  Created by Tiago Mota on 09/03/16.
//  Copyright © 2016 tiagomota.eu. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class Pokemon : Mappable {
    
    private var _pokeId: Int!
    private var _name : String!
    
    
    init(name: String, pokeId: Int) {
        self._name = name
        self._pokeId = pokeId
    }
    
    
    required init?(_ map: Map){
        
    }
    
    
    func mapping(map: Map) {
        _pokeId <- map["id"]
        _name <- map["name"]
    }
    
    // ************
    //   Getters
    // ************
    var name : String {
        return _name
    }
    
    var pokeId : Int {
        return _pokeId
    }
    
}