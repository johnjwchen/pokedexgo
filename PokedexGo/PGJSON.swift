//
//  PGJSON.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/3/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class PGJSON: NSObject {
    static let layout = PGHelper.convertToDictionary(name: "layout")
    static let moveDex = PGHelper.convertToDictionary(name: "movedex-go")
    static let pokeDex = PGHelper.convertToDictionary(name: "godex")
    static func moveOf(name: String) -> [String: Any] {
        let name2 = name.lowercased().replacingOccurrences(of: " ", with: "-")
        return moveDex![name2] as! [String: Any]
    }
}
