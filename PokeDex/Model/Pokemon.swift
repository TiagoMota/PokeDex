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
    
    private var _pokeId : Int?
    private var _name : String!
    private var _url : String?
    
    
    init(name: String, pokeId: Int) {
        self._name = name
        self._pokeId = pokeId
    }
    
    
    required init?(_ map: Map){
        
    }
    
    
    func mapping(map: Map) {
        self._pokeId <- map["id"]
        self._name <- map["name"]
        self._url <- map["url"]
    }
    
    // ************
    //   Getters
    // ************
    var name : String {
        return self._name
    }
    
    var pokeId : Int? {
        set(id) {
            self._pokeId = id
        }
        
        get {
            return self._pokeId
        }
        
    }
    
    var url : String? {
        return self._url
    }
    
}