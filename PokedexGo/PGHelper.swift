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
                self.superview?.setNeedsLayout()
                self.superview?.layoutSubviews()
                self.superview?.superview?.setNeedsLayout()
                self.superview?.superview?.layoutSubviews()
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}



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
    class func imageUrlOfPokemon(width: NSInteger, num: NSInteger) -> URL! {
        let url = String(format: "https://pokedex.me/new-pokemon/%d/%03d.png", width, num)
        return URL(string: url)
    }
    
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
