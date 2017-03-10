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
    
    static func moveOf(name: String) -> [String: Any] {
        let name2 = name.lowercased().replacingOccurrences(of: " ", with: "-")
        return moveDex[name2] as! [String: Any]
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
