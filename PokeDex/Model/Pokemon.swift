//
//  File.swift
//  PokeDex
//
//  Created by Tiago Mota on 09/03/16.
//  Copyright © 2016 tiagomota.eu. All rights reserved.
//

import Foundation
import ObjectMapper

class Pokemon : Mappable {
    
    private var _pokeId : Int!
    private var _name : String!
    private var _description : String?
    private var _descriptions : [Description]!
    private var _types : [Type]!
    private var _defense : String!
    private var _attack : String!
    private var _height : String!
    private var _weight : String!
    private var _nextEvolutionTxt : String!
    
    
    init(name: String, pokeId: Int) {
        self._name = name
        self._pokeId = pokeId
    }
    
    
    required init?(_ map: Map){
        
    }
    
    
    func mapping(map: Map) {
        self._pokeId <- map["id"]
        self._name <- map["name"]
        self._descriptions <- map["descriptions"]
        self._types <- map["types"]
        self._attack <- map["attack"]
        self._defense <- map["defense"]
        self._height <- map["height"]
        self._weight <- map["weight"]
    }
    
    // ************
    //   Getters
    // ************
    var name : String {
        return self._name
    }
    
    var pokeId : Int! {
        set(id) {
            self._pokeId = id
        }

        get {
            return self._pokeId
        }
    }
    
    var description : String? {
        set(desc) {
            self._description = desc
        }
        
        get {
            return self._description
        }
        
    }
    
    var descriptions : [Description] {
        return self._descriptions
    }
    
    var types : [Type] {
        return self._types
    }
    
    var attack : String {
        return self._attack
    }
    
    var defense : String {
        return self._defense
    }
    
    var height : String {
        return self._height
    }
    
    var weight : String {
        return self._weight
    }
}