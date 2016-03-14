//
//  Type.swift
//  PokeDex
//
//  Created by Tiago Mota on 14/03/16.
//  Copyright © 2016 tiagomota.eu. All rights reserved.
//

import Foundation
import ObjectMapper

class Type : Mappable {
    
    private var _name : String!
    private var _url : String!
    
    required init?(_ map: Map){
        
    }
    
    
    func mapping(map: Map) {
        self._name <- map["name"]
        self._url <- map["resource_uri"]
    }
    
    var name : String {
        return self._name
    }
    
    var url : String {
        return self._url
    }
}