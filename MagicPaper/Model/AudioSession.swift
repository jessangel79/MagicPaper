//
//  AudioSession.swift
//  MagicPaper
//
//  Created by Angelique Babin on 05/05/2021.
//

import AVFoundation

struct AudioSession {
    
    private var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: Constants.harryPotter, withExtension: Constants.mp4) else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            let player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
