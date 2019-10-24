//
//  MusicPlayer.swift
//  musicPlayerTestApp
//
//  Created by Admin on 24.10.2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import AVFoundation

class MusicPlayer {
    
    var player = AVPlayer()
    
    func initPlayer(url : String) {
        guard let url = URL.init(string: url) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        _ = AVAudioSession.sharedInstance().outputVolume
        player = AVPlayer.init(playerItem: playerItem)
        playAudioBackground()
    }
    
    func playAudioBackground() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
    }
    
    func pause(){
        player.pause()
    }
    
    func play() {
        player.play()
    }
    
    func stop() {
        player.seek(to: CMTime.zero)
    }
}




