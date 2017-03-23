//
//  PGJSON.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/3/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit


class PGJSON: NSObject {
    static let layout = PGHelper.jsonFrom(name: "layout") as! [String: Any]
    static let moveDex = PGHelper.jsonFrom(name: "movedex-go") as! [String: Any]
    static let pokeDex = PGHelper.jsonFrom(name: "godex") as! [String: Any]
    static let pokemonDescArray = PGHelper.jsonFrom(name: "pokemon_desc_30") as! [Any]
    static let evolutionDict = PGHelper.jsonFrom(name: "evolution") as! [String: Any]
    
    
    static var sortedMoveDict: [String: Any]! = [:]
    
    @discardableResult
    static func sortedMove(key: String) -> [String] {
        let low = key.lowercased()
        var array = sortedMoveDict[low] as? [String]
        if array == nil {
            array = sortedMoveArray(key: low)
            sortedMoveDict[low] = array
        }
        return array!
    }
    static private func sortedMoveArray(key: String) -> [String] {
        let array = moveDex.values.sorted { (a, b) -> Bool in
            return sort(a: a, b: b, key: key)
        }
        var sortedArray: [String] = []
        for item in array {
            let dict = item as! [String: Any]
            let name = dict["name"] as! String
            sortedArray.append(PGHelper.keyString(moveName: name))
        }
        return sortedArray
    }
    
    static func sort(a: Any, b: Any, key: String, up: Bool = true) -> Bool {
        let move1 = a as! [String: AnyObject]
        let move2 = b as! [String: AnyObject]
        if let s1 = move1[key] as? String, let s2 = move2[key] as? String {
            return up ? s1 > s2 : s1 < s2
        }
        else if let d1 = move1[key] as? Double, let d2 = move2[key] as? Double {
            return up ? d1 > d2 : d1 < d2
        }
        else if let f1 = move1[key] as? Float, let f2 = move2[key] as? Float {
            return up ? f1 > f2 : f1 < f2
        }
        else if let v1 = move1[key] as? Int, let v2 = move2[key] as? Int {
            return up ? v1 > v2 : v1 < v2
        }
        else {
            return false
        }
    }
    
    static var sortedPokemonDict: [String: Any]! = [:]
    @discardableResult
    static func sortedPokemon(key: String) -> [String] {
        let low = key.lowercased()
        var array = sortedPokemonDict[low] as? [String]
        if array == nil {
            array = sortedPokemonArray(key: low)
            sortedPokemonDict[low] = array
        }
        return array!
    }
    
    static private func sortedPokemonArray(key: String) -> [String] {
        let array = pokeDex.values.sorted { (a, b) -> Bool in
            return sort(a: a, b: b, key: key)
        }
        var sortedArray: [String] = []
        for item in array {
            let dict = item as! [String: Any]
            let num = dict["num"] as! Int
            sortedArray.append(String(num))
        }
        return sortedArray
    }
    
    
    
    static func moveOf(name: String) -> [String: Any] {
        let name2 = name.lowercased().replacingOccurrences(of: " ", with: "-")
        return moveDex[name2] as! [String: Any]
    }
    
    static private var pokemonEvolution: [String: String]!
    // get evolution info from pokemon name
    static func evolutionOf(pokemonName: String) -> [String: Any]? {
        if pokemonEvolution == nil {
            pokemonEvolution = Dictionary()
            for key in evolutionDict.keys {
                let nameArray = key.characters.split(separator: "-").map(String.init)
                for name in nameArray {
                    pokemonEvolution[name] = key
                }
            }
        }
        
        let key = pokemonEvolution[pokemonName.lowercased()]
        if key == nil {
            return nil
        }
        return evolutionDict[key!] as? [String: Any]
    }
    
    static private var movePokemon: [String: Any]!
    static func pokemonWith(moveKey: String) -> [String]? {
        if (movePokemon == nil) {
            movePokemon = [:]
            for key in pokeDex.keys {
                let pokemon = pokeDex[key] as! [String: Any]
                for key2 in ["fastMoves", "chargeMoves"] {
                    for mName in pokemon[key2] as! [String?] {
                        let mKey = PGHelper.keyString(moveName: mName) as String
                        if (movePokemon[mKey] == nil) {
                            movePokemon[mKey] = [key]
                        }
                        else {
                            var array = movePokemon[mKey] as! [String]
                            array.append(key)
                            movePokemon[mKey] = array
                        }
                    }
                }
            }
        }
        return movePokemon[moveKey] as? [String]
    }
}
