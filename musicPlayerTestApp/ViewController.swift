//
//  ViewController.swift
//  musicPlayerTestApp
//
//  Created by Admin on 23.10.2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    class MusicPlayer {
        public static var instance = MusicPlayer()
        var player = AVPlayer()
        
        func initPlayer(url : String) {
            guard let url = URL.init(string: url) else { return }
            let playerItem = AVPlayerItem.init(url: url)
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
    
    
    
    var player = MusicPlayer()
    let tasteURL = "https://ia802508.us.archive.org/5/items/testmp3testfile/mpthreetest.mp3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.initPlayer(url: tasteURL)
        
        let buttonPlay = UIButton(frame: CGRect(x: 50, y: 300, width: 100, height: 50))
        buttonPlay.setTitle("Play music", for: .normal)
        buttonPlay.setTitleColor(.black, for: .normal)
        buttonPlay.backgroundColor = .green
        buttonPlay.addTarget(self, action: #selector(buttonActionPlay), for: .touchUpInside)
        self.view.addSubview(buttonPlay)
        
        let buttonPause = UIButton(frame: CGRect(x: 200, y: 300, width: 120, height: 50))
        buttonPause.setTitle("Pause music", for: .normal)
        buttonPause.setTitleColor(.black, for: .normal)
        buttonPause.backgroundColor = .yellow
        buttonPause.addTarget(self, action: #selector(buttonActionPause), for: .touchUpInside)
        self.view.addSubview(buttonPause)
        
        let buttonStop = UIButton(frame: CGRect(x: 120, y: 400, width: 100, height: 50))
        buttonStop.setTitle("Stop", for: .normal)
        buttonStop.setTitleColor(.black, for: .normal)
        buttonStop.backgroundColor = .red
        buttonStop.addTarget(self, action: #selector(buttonActionStop), for: .touchUpInside)
        self.view.addSubview(buttonStop)
        
    }
    
    @objc func buttonActionPlay(sender: UIButton!) {
        print("buttonActionPlay tapped")
        player.play()
    }
    
    @objc func buttonActionPause(sender: UIButton!) {
        print("buttonActionPause tapped")
        player.pause()
    }
    
    @objc func buttonActionStop(sender: UIButton!) {
        print("buttonActionStop tapped")
        player.stop()
        player.pause()
    }
}
