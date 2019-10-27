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

class ViewController: UIViewController {
    
    var player = MusicPlayer()
    
    //let URL
    let tasteURL = "https://ia802508.us.archive.org/5/items/testmp3testfile/mpthreetest.mp3"
    
    //True or false metod
    var buttonPlayTriger = true
    
    //True or false metod
    var buttonMuteTriger = false
    
    //Timer for tracking the progress
    var timer: Timer? = nil
    
    //image buttons
    let imagePlay = UIImage(#imageLiteral(resourceName: "ic_play_arrow_48px")).withTintColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
    let imagePause = UIImage(#imageLiteral(resourceName: "ic_pause_48px")).withTintColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
    let imageStop = UIImage(#imageLiteral(resourceName: "ic_stop_48px")).withTintColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
    let imageVolumeUP = UIImage(#imageLiteral(resourceName: "ic_volume_up_48px")).withTintColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
    let imageVolumeDOWN = UIImage(#imageLiteral(resourceName: "ic_volume_off_48px")).withTintColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
    
    //texr field
    let textField = UITextField(frame: CGRect(x: 25, y: 100, width: 325, height: 50))
    
    //text progress
    let textLabelProgress = UITextView(frame: CGRect(x: 170, y: 250, width: 200, height: 75))
    
    //progress bar
    let progressBar = UIProgressView(frame: CGRect(x: 90, y: 280, width: 200, height: 75))
    
    //buttons
    let buttonPlayOrPause = UIButton(frame: CGRect(x: 90, y: 300, width: 50, height: 50))
    let buttonStop = UIButton(frame: CGRect(x: 220, y: 300, width: 50, height: 50))
    let buttonMute = UIButton(frame: CGRect(x: 150, y: 470, width: 50, height: 50))
    
    //text volume
    let textLabelVolume = UITextView(frame: CGRect(x: 155, y: 380, width: 200, height: 75))
    
    //volume slider
    let volumeSlider = UISlider(frame: CGRect(x: 90, y: 400, width: 200, height: 75))
    
    //hide keyboard  afte tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true) // Скрытие клавиатуры вызванной для любого объекта
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test url init
        player.initPlayer(url: tasteURL)
        
        //init textField
        textField.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.text = "add your URL mp3"
        textField.borderStyle = .roundedRect
        textField.clearsOnBeginEditing = true
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(75)
            make.left.equalTo(view).offset(25)
            make.right.equalTo(view).offset(-25)
            make.bottom.equalTo(view).offset(-550)
        }
        
        //init textLabelProgress and progress
        textLabelProgress.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textLabelProgress.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        textLabelProgress.text = "0 : 0"
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.progressBar.progress = Float(CMTimeGetSeconds(self.player.player.currentTime()) / CMTimeGetSeconds(self.player.availableDuration()))
            self.textLabelProgress.text = "\(Int(CMTimeGetSeconds(self.player.player.currentTime()))) : \(Int(CMTimeGetSeconds(self.player.availableDuration())))"
        }
        
        self.view.addSubview(textLabelProgress)
        textLabelProgress.snp.makeConstraints { (make) in
            make.size.greaterThanOrEqualTo(textField)
//            make.top.equalTo(textField).offset(50)
//            make.left.equalTo(view).offset(200)
//            make.right.equalTo(view).offset(-200)
            make.center.equalTo(view)
        }
        
        self.view.addSubview(progressBar)
        progressBar.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(250)
            make.left.equalTo(view).offset(25)
            make.right.equalTo(view).offset(-25)
            make.centerX.equalTo(view)
        }
        
        //init buttonPlayOrPause
        buttonPlayOrPause.setBackgroundImage(imagePlay, for: .normal)
        buttonPlayOrPause.setTitleColor(.black, for: .normal)
        buttonPlayOrPause.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        buttonPlayOrPause.addTarget(self, action: #selector(buttonActionPlayOrPause), for: .touchUpInside)
        self.view.addSubview(buttonPlayOrPause)
        
        //init buttonPlayOrPause
        buttonStop.setBackgroundImage(imageStop, for: .normal)
        buttonStop.setTitleColor(.black, for: .normal)
        buttonStop.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        buttonStop.addTarget(self, action: #selector(buttonActionStop), for: .touchUpInside)
        self.view.addSubview(buttonStop)
        
        buttonMute.setBackgroundImage(imageVolumeUP, for: .normal)
        buttonMute.setTitleColor(.black, for: .normal)
        buttonMute.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        buttonMute.addTarget(self, action: #selector(buttonMuteAction), for: .touchUpInside)
        self.view.addSubview(buttonMute)
        
        textLabelVolume.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textLabelVolume.text = "Volume 15%"
        self.view.addSubview(textLabelVolume)
        
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 100
        volumeSlider.setValue(15, animated: true)
        player.player.volume = volumeSlider.value
        
        volumeSlider.addTarget(self, action: #selector(SliderActionVolume), for: .allTouchEvents)
        self.view.addSubview(volumeSlider)
    }
    
    @objc func buttonActionPlayOrPause(sender: UIButton!) {
        print("buttonActionPlay tapped")
        
        buttonPlayTriger.toggle()
        
        let url = textField.text
        
        func buttonPlayPause() {
            if buttonPlayTriger {
                player.pause()
                buttonPlayOrPause.setBackgroundImage(imagePlay, for: .normal)
            } else {
                player.play()
                buttonPlayOrPause.setBackgroundImage(imagePause, for: .normal)
            }
        }
        
        if url!.isEmpty {
            player.initPlayer(url: tasteURL)
            buttonPlayPause()
        } else {
            player.initPlayer(url: url!)
            buttonPlayPause()
        }
        
    }
    
    @objc func buttonActionStop(sender: UIButton!) {
        print("buttonActionStop tapped")
        player.stop()
        player.pause()
        player.player.seek(to: CMTime.zero)
        
        buttonPlayTriger = false
        if buttonPlayTriger {
            buttonPlayOrPause.setBackgroundImage(imagePause, for: .normal)
        } else {
            buttonPlayTriger = true
            buttonPlayOrPause.setBackgroundImage(imagePlay, for: .normal)
        }
    }
    
    @objc func SliderActionVolume(sender: UISlider!) {
        player.player.volume = volumeSlider.value
        textLabelVolume.text = "Volume \(Int(volumeSlider.value))%"
        
        if player.player.volume == 0 {
            buttonMute.setBackgroundImage(imageVolumeDOWN, for: .normal)
        } else {
            buttonMute.setBackgroundImage(imageVolumeUP, for: .normal)
        }
    }
    
    @objc func buttonMuteAction(sender: UIButton!) {
        print("buttonMute tapped")
        buttonMuteTriger.toggle()
        
        if buttonMuteTriger {
            buttonMuteTriger = true
            player.muted()
            buttonMute.setBackgroundImage(imageVolumeDOWN, for: .normal)
        } else {
            buttonMuteTriger = false
            player.unmuted()
            buttonMute.setBackgroundImage(imageVolumeUP, for: .normal)
        }
    }
}
