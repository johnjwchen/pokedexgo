//
//  ImageTableViewCell.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/3/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit
import AVFoundation

class ImageTableViewCell: UITableViewCell, AVAudioPlayerDelegate {

    @IBOutlet weak var centralImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    var player: AVAudioPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        playButton.isHidden = true
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageTap(_:)))
//        centralImage.addGestureRecognizer(gesture)
    }
    
    func imageTap(_ gesture: UITapGestureRecognizer) {
        playSound()
    }
    
    @IBAction func playTouchUp(_ sender: Any) {
        playSound()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
    }
    
    
    func playSound() {
        if player?.isPlaying == true {
            return
        }
        playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        player?.play()
    }
    
    
    func setPokemonImage(num: Int) {
        centralImage.downloadedFrom(url: PGHelper.imageUrlOfPokemon(width: 240, num: num), placeHolder: #imageLiteral(resourceName: "placeholder80"))
        // load cry soud
        loadSound(num: num)
    }

    private func loadSound(num: Int) {
        if player != nil {
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            let urlstring = String(format: "https://pokgear.com/audio/mp3/%03d.mp3", num)
            guard let url = URL(string: urlstring) else {
                return
            }
            do {
                /// this codes for making this app ready to takeover the device audio
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
               
                let data = try Data(contentsOf: url)
                self.player = try AVAudioPlayer(data: data)
                self.player?.delegate = self
                DispatchQueue.main.async {
                    self.playButton.isHidden = false
                }
            } catch let error as NSError {
                print("error: \(error.localizedDescription)")
            }
        }
        
    }
}
