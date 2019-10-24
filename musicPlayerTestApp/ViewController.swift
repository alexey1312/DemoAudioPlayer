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
    let buttonPlay = UIButton(frame: CGRect(x: 90, y: 300, width: 75, height: 75))
    let buttonStop = UIButton(frame: CGRect(x: 220, y: 300, width: 75, height: 75))
    
    //text volume
    let textLabel = UITextView(frame: CGRect(x: 155, y: 380, width: 200, height: 75))
    
    //volume slider
    let volumeSlider = UISlider(frame: CGRect(x: 90, y: 400, width: 200, height: 75))
    
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
        
        textLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textLabel.text = "Volume 30%"
        self.view.addSubview(textLabel)
        
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 100
        volumeSlider.setValue(30, animated: true)
        volumeSlider.addTarget(self, action: #selector(SliderActionVolume), for: .allTouchEvents)
        self.view.addSubview(volumeSlider)
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
    
    @objc func SliderActionVolume(sender: UISlider!) {
        player.player.volume = volumeSlider.value
        textLabel.text = "Volume \(Int(volumeSlider.value))%"
    }
}
