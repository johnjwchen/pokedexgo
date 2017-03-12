//
//  PGHelper.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/2/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

extension UIButton {
    func downloadedFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.setBackgroundImage(image, for: .normal)
            }
            }.resume()
    }
    func downloadedFrom(link: String) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url)
    }
}

//extension String {
//    mutating func stringByRemovingRegexMatches(pattern: String, replaceWith: String = "") {
//        do {
//            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
//            let range = NSMakeRange(0, self.characters.count)
//            self = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
//        } catch {
//            return
//        }
//    }
//}


class PGHelper: NSObject {
    
    /**
     return the pokemon image url base on pokemon id (num)
     
     - parameter width: with of the image
     - parameter num: pokemon id
     - returns: the URL object
     
     - Remark:
     There's a counterpart function that concatenates the first and last name into a full name.
     
     
     - Precondition: `fullname` should not be nil.
     - Requires: Both first and last name should be parts of the full name, separated with a *space character*.

    */
    class func imageUrlOfPokemon(width: Int, num: Int) -> URL! {
        var w = Float(width) * Float(UIScreen.main.scale)
        if w > 480 {
            w = 480
        }
        let url = String(format: "https://pokedex.me/new-pokemon/%d/%03d.png", Int(w), num)
        return URL(string: url)
    }
    
    class func keyString(moveName: String!) -> String! {
        let key = moveName.replacingOccurrences(of: " ", with: "-")
        return key.lowercased()
    }
    
    static let attackArray: [[Float]] = [
        [1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1],// 0: not used
        [1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,0.5,  0,  1,  1,0.5,  1],// 1: normal
        [1,  1,0.5,0.5,  1,  2,  2,  1,  1,  1,  1,  1,  2,0.5,  1,0.5,  1,  2,  1],// 2: Fire
        [1,  1,  2,0.5,  1,0.5,  1,  1,  1,  2,  1,  1,  1,  2,  1,0.5,  1,  1,  1],// 3: Water
        [1,  1,  1,  2,0.5,0.5,  1,  1,  1,  0,  2,  1,  1,  1,  1,0.5,  1,  1,  1],// 4: Electric
        [1,  1,0.5,  2,  1,0.5,  1,  1,0.5,  2,0.5,  1,0.5,  2,  1,0.5,  1,0.5,  1],// 5: Grass
        [1,  1,0.5,0.5,  1,  2,0.5,  1,  1,  2,  2,  1,  1,  1,  1,  2,  1,0.5,  1],// 6: Ice
        [1,  2,  1,  1,  1,  1,  2,  1,0.5,  1,0.5,0.5,0.5,  2,  0,  1,  2,  2,0.5],// 7: Fighting
        [1,  1,  1,  1,  1,  2,  1,  1,0.5,0.5,  1,  1,  1,0.5,0.5,  1,  1,  0,  2],// 8: Poison
        [1,  1,  2,  1,  2,0.5,  1,  1,  2,  1,  0,  1,0.5,  2,  1,  1,  1,  2,  1],// 9: Ground
        [1,  1,  1,  1,0.5,  2,  1,  2,  1,  1,  1,  1,  2,0.5,  1,  1,  1,0.5,  1],//10: Flying
        [1,  1,  1,  1,  1,  1,  1,  2,  2,  1,  1,0.5,  1,  1,  1,  1,  0,0.5,  1],//11: Psychic
        [1,  1,0.5,  1,  1,  2,  1,0.5,0.5,  1,0.5,  2,  1,  1,0.5,  1,  2,0.5,0.5],//12: Bug
        [1,  1,  2,  1,  1,  1,  2,0.5,  1,0.5,  2,  1,  2,  1,  1,  1,  1,0.5,  1],//13: Rock
        [1,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  1,  1,  2,  1,0.5,  1,  1],//14: Ghost
        [1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  1,0.5,  0],//15: Dragon
        [1,  1,  1,  1,  1,  1,  1,0.5,  1,  1,  1,  2,  1,  1,  2,  1,0.5,  1,0.5],//16: Dark
        [1,  1,0.5,0.5,0.5,  1,  2,  1,  1,  1,  1,  1,  1,  2,  1,  1,  1,0.5,  2],//17: Steel
        [1,  1,0.5,  1,  1,  1,  1,  2,0.5,  1,  1,  1,  1,  1,  1,  2,  2,0.5,  1] //18: Fairy
    ]
    
    static var defenseArray: [[Float]]? = nil
    private class func writeDefenseArray() {
        defenseArray = []
        for i in 0...18 {
            var ar: [Float] = []
            for j in 0...18 {
                ar.append(attackArray[j][i])
            }
            defenseArray!.append(ar)
        }
    }
    
    static let typeNameDict: [String: Int] = [
        "normal": 1,
        "fire": 2,
        "water": 3,
        "electric": 4,
        "grass": 5,
        "ice": 6,
        "fighting": 7,
        "poison": 8,
        "ground": 9,
        "flying": 10,
        "psychic": 11,
        "bug": 12,
        "rock": 13,
        "ghost": 14,
        "dragon": 15,
        "dark": 16,
        "steel": 17,
        "fairy": 18
    ]
    class func typeOf(name: String) -> Int {
        guard let type = typeNameDict[name.lowercased()] else {
            return 0
        }
        return type
    }
    
    class func effectOn(typeNames: [String]) -> [String: Any] {
        var types = [typeOf(name: typeNames.first!)]
        var i = 1
        while i < typeNames.count {
            types.append(typeOf(name: typeNames[i]))
            i += 1
        }
        return effectOn(pokemonTypes: types)
    }
    
    /**
     get the effectiveness (super-effective, not very effective) of type(s)
    
    */
    class func effectOn(pokemonTypes: [Int]) -> [String: Any] {
        if defenseArray == nil {
            writeDefenseArray()
        }
        var effects = ["super": [], "less": []]
        var array = defenseArray![pokemonTypes[0]]
        var index = 1
        while(index < pokemonTypes.count) {
            var ar = defenseArray![pokemonTypes[index]]
            for i in 1...18 {
                array[i] = array[i] * ar[i]
            }
            index += 1
        }
        var superArray: [Any] = []
        var lessArray: [Any] = []
        for i in 1...18 {
            let eff = array[i]
            if eff > 1 {
                superArray.append([i, eff])
            }
            if eff < 1 {
                lessArray.append([i, eff])
            }
        }
        effects["super"] = superArray.sorted(by: { (a, b) -> Bool in
            let ar1 = a as! [Any]
            let ar2 = b as! [Any]
            let f1 = ar1[1] as! Float
            let f2 = ar2[1] as! Float
            
            return f1 > f2
        })
        effects["less"] = lessArray.sorted(by: { (a, b) -> Bool in
            let ar1 = a as! [Any]
            let ar2 = b as! [Any]
            let f1 = ar1[1] as! Float
            let f2 = ar2[1] as! Float
            
            return f1 < f2
        })
        
        return effects
    }
    
    /**
     parse json file to Array or Dictionary
     
     - parameter name: json file name *without extension*
     - returns: Array or Dictionary. *can be nil*
    */
    class func jsonFrom(name: String) -> Any? {
        do {
            if let file = Bundle.main.url(forResource: name, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    return object
                } else if let object = json as? [Any] {
                    // json is an array
                    return object
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
