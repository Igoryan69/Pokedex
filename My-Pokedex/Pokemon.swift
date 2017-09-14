//
//  Pokemon.swift
//  My-Pokedex
//
//  Created by Игорь Антонченко on 13.09.17.
//  Copyright © 2017 Игорь Антонченко. All rights reserved.
//

import Foundation
import Alamofire




class Pokemon {
    private var _name: String!
    private var _pokedexId: Int
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _evo: String!
    private var _evoId: String!
    private var _evoLvl: String!
    private var _pokemonUrl: String
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight:String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    var evo: String {
        if _evo == nil {
            _evo = ""
        }
        return _evo
    }
    var evoId: String {
        if _evoId == nil {
            _evoId = ""
        }
        return _evoId
    }
    var evoLvl: String {
        if _evoLvl == nil {
            _evoLvl = ""
        }
        return _evoLvl
    }
    
    
    
    
    
    
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
        
        
        //  print(_pokemonUrl)
    }
    func downloadPokemonDetails(completed: @escaping DownloadComplete ) {
        let url = URL(string: _pokemonUrl)!
        // let newurl = URL(string: url)      //  "http://pokeapi.com/api/v1/pokemon/5/")!
        print(url)
        
        
        Alamofire.request(url).responseJSON { (response:DataResponse<Any>) in
            
            //            if let dict = response.result.value as? Dictionary<String,AnyObject> {
            //              //  print(dict)
            //
            if let dict = response.result.value as? Dictionary<String, AnyObject>  {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let hight = dict["height"] as? String {
                    self._height = hight
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    
                    if let name = types[0] ["name"] {
                        self._type = name
                    }
                    
                    if types.count > 1 {
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name)"
                            }
                        }
                    }
                    
                }else {
                    self._type = ""
                }
                
                print(self._type)
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let requrl = URL(string: "\(URL_BASE)\(url)")!
                        
                        Alamofire.request(requrl).responseJSON { (response:DataResponse<Any>) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            completed()
                        }
                    }
                }else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        
                   //      its mean mega is not found
                        if to.range(of: "mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"]  as? String {
                               let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let num = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._evoId = num
                                self._evo = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._evoLvl = "\(lvl)"
                                }
                                
                                print(self._evoId)
                                print(self._evo)
                                print(self._evoLvl)
                            }
                        }
                    }
                }
                
                
                
            }
            
            
        }
        
        
        
        
        
        //       Alamofire.request(.get, url).responseJSON { (response:DataResponse<Any>) in
        
        
        //     Alamofire.request(url, method: .get).responseJSON { (response: DataResponse<Any>) in
        
        //            if response.result.value != nil {
        //
        //               let dict = JSON(response.result.value!)
        //                print(dict)
        //            }
        
        //            if let dict = response.result.value as? Dictionary<String, AnyObject> {
        //                if let weight = dict["weight"] as? String {
        //                    self._weight = weight
        //                }
        //                if let hight = dict["height"] as? String {
        //                    self._height = hight
        //                }
        //                if let attack = dict["attack"] as? Int {
        //                    self._attack = "\(attack)"
        //                }
        //                if let defense = dict["defense"] as? Int {
        //                    self._defense = "\(defense)"
        //                }
        //
        //                print(self._defense)
        //                print(self._attack)
        //                print(self._height)
        //                print(self._weight)
        //            }
        //
        // print(response.value.debugDescription)
        // }
        
        
        
        
    }
}
