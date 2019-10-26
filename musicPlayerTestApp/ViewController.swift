//
//  ViewController.swift
//  musicPlayerTestApp
//
//  Created by Admin on 23.10.2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit
import MediaPlayer

class ViewController: UIViewController {
    
    var player = MusicPlayer()
    
    //let URL
    let tasteURL = "https://ia802508.us.archive.org/5/items/testmp3testfile/mpthreetest.mp3"
    
    //True or false metod
    var button = true
    
    //Timer for tracking the progress
    var timer: Timer? = nil
    
    //image buttons
    let imagePlay = UIImage(#imageLiteral(resourceName: "ic_play_arrow_48px")).withTintColor(.black)
    let imagePause = UIImage(#imageLiteral(resourceName: "ic_pause_circle_outline_48px")).withTintColor(.black)
    let imageStop = UIImage(#imageLiteral(resourceName: "ic_stop_48px")).withTintColor(.black)
    
    //texr field
    let textField = UITextField(frame: CGRect(x: 25, y: 100, width: 325, height: 50))
    
    //text progress
    let textLabelProgress = UITextView(frame: CGRect(x: 165, y: 250, width: 200, height: 75))
    
    //progress bar
    let progressBar = UIProgressView(frame: CGRect(x: 90, y: 280, width: 200, height: 75))
    
    //buttons
    let buttonPlay = UIButton(frame: CGRect(x: 90, y: 300, width: 75, height: 75))
    let buttonStop = UIButton(frame: CGRect(x: 220, y: 300, width: 75, height: 75))
    
    //text volume
    let textLabelVolume = UITextView(frame: CGRect(x: 155, y: 380, width: 200, height: 75))
    
    //volume slider
    let volumeSlider = UISlider(frame: CGRect(x: 90, y: 400, width: 200, height: 75))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test url init
        player.initPlayer(url: tasteURL)
        
        textField.backgroundColor = .yellow
        textField.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.text = "add your URL mp3"
        textField.borderStyle = .line
        textField.clearsOnBeginEditing = true
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(textField)
        
        textLabelProgress.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textLabelProgress.text = "0 : 0"
                
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            self.progressBar.progress = Float(CMTimeGetSeconds(self.player.player.currentTime()) / CMTimeGetSeconds(self.player.availableDuration()))
            
            self.textLabelProgress.text = "\(Int(CMTimeGetSeconds(self.player.player.currentTime()))) : \(Int(CMTimeGetSeconds(self.player.availableDuration())))"
        }
        
        self.view.addSubview(textLabelProgress)
        self.view.addSubview(progressBar)
        
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
        
        textLabelVolume.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textLabelVolume.text = "Volume 30%"
        self.view.addSubview(textLabelVolume)
        
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 100
        volumeSlider.setValue(30, animated: true)
        volumeSlider.addTarget(self, action: #selector(SliderActionVolume), for: .allTouchEvents)
        self.view.addSubview(volumeSlider)
    }
    
    @objc func buttonActionPlayOrPause(sender: UIButton!) {
        print("buttonActionPlay tapped")
        button.toggle()
        
        let url = textField.text
        
        if url!.isEmpty {
            player.initPlayer(url: tasteURL)
        } else {
            player.initPlayer(url: url!)
        }
        
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
        player.player.seek(to: CMTime.zero)
        
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
        textLabelVolume.text = "Volume \(Int(volumeSlider.value))%"
    }
}
