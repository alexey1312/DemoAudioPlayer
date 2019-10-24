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
    
    var player = MusicPlayer()
    //let URL
    let tasteURL = "https://ia802508.us.archive.org/5/items/testmp3testfile/mpthreetest.mp3"
    
    var button = true
    
    //image buttons
    let imagePlay = UIImage(#imageLiteral(resourceName: "ic_play_arrow_48px")).withTintColor(.black)
    let imagePause = UIImage(#imageLiteral(resourceName: "ic_pause_circle_outline_48px")).withTintColor(.black)
    let imageStop = UIImage(#imageLiteral(resourceName: "ic_stop_48px")).withTintColor(.black)
    
    //buttons
    let buttonPlay = UIButton(frame: CGRect(x: 75, y: 300, width: 75, height: 75))
    let buttonStop = UIButton(frame: CGRect(x: 200, y: 300, width: 75, height: 75))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.initPlayer(url: tasteURL)
        
        buttonPlay.setBackgroundImage(imagePlay, for: .normal)
        buttonPlay.setTitleColor(.black, for: .normal)
        buttonPlay.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        buttonPlay.addTarget(self, action: #selector(buttonActionPlayOrPause), for: .touchUpInside)
        self.view.addSubview(buttonPlay)
        
        buttonStop.setBackgroundImage(imageStop, for: .normal)
        buttonStop.setTitleColor(.black, for: .normal)
        buttonStop.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        buttonStop.addTarget(self, action: #selector(buttonActionStop), for: .touchUpInside)
        self.view.addSubview(buttonStop)
    }
    
    @objc func buttonActionPlayOrPause(sender: UIButton!) {
        print("buttonActionPlay tapped")
        button.toggle()
        
        if button {
            player.pause()
            buttonPlay.setBackgroundImage(imagePlay, for: .normal)
        } else {
            player.play()
            buttonPlay.setBackgroundImage(imagePause, for: .normal)
        }
    }
    
    @objc func buttonActionStop(sender: UIButton!) {
        print("buttonActionStop tapped")
        player.stop()
        player.pause()
        
        button = false
        if button {
            buttonPlay.setBackgroundImage(imagePause, for: .normal)
        } else {
            button = true
            buttonPlay.setBackgroundImage(imagePlay, for: .normal)
        }
    }
}
