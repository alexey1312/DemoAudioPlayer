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
    var volumeDefault: Float = 15

    //let URL
    let testURL = "https://ruz.hitmos.org/get/music/20170903/muzlome_Rick_Astley_-_Never_Gonna_Give_You_Up_48032892.mp3"

    //True or false metod
    var buttonPlayTriger = true

    //True or false metod
    var buttonMuteTriger = false

    //Timer for tracking the progress
    var timer: Timer?

    //image buttons
    let imagePlay = UIImage(#imageLiteral(resourceName: "ic_play_arrow_48px")).withTintColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    let imagePause = UIImage(#imageLiteral(resourceName: "ic_pause_48px")).withTintColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    let imageStop = UIImage(#imageLiteral(resourceName: "ic_stop_48px")).withTintColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    let imageVolumeUP = UIImage(#imageLiteral(resourceName: "ic_volume_up_48px")).withTintColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    let imageVolumeDOWN = UIImage(#imageLiteral(resourceName: "ic_volume_off_48px")).withTintColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))

    //texr field
    let textField = UITextField(frame: CGRect(x: 25, y: 100, width: 325, height: 50))

    //text progress
    let textLabelProgress = UITextView(frame: CGRect(x: 170, y: 250, width: 100, height: 75))

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

        //setup test url
        player.initPlayer(url: testURL)

        //setup textField
        setupTextField()

        //setup textLabelProgress and progress
        setupTextLabelProgress()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
        self.progressBar.progress =
            Float(CMTimeGetSeconds(self.player.player.currentTime()) / CMTimeGetSeconds(self.player.availableDuration()))

        self.textLabelProgress.text =
            "\(Int(CMTimeGetSeconds(self.player.player.currentTime()))) : \(Int(CMTimeGetSeconds(self.player.availableDuration())))"
        }

        self.view.addSubview(progressBar)

        //setup
        setupButtonPlayOrPause()
        setupButtonStop()
        setupButtonMute()
        setupTextLabelVolume()
        setupVolumeSlider()

        //add constraints
        addConstraint()
    }

    private func addConstraint() {
        //progressBar
        progressBar.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(250)
            make.left.equalTo(view).offset(25)
            make.right.equalTo(view).offset(-25)
            make.centerX.equalTo(view)
        //textLabelProgress
        textLabelProgress.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 150, height: 25))
            make.centerX.equalTo(view)
            make.centerY.equalTo(textField).offset(125)
            }
        //volumeSlider
        volumeSlider.snp.makeConstraints { (make) in
            make.top.equalTo(textLabelVolume).offset(25)
            make.left.equalTo(view).offset(50)
            make.right.equalTo(view).offset(-50)
            make.centerX.equalTo(view)
            }
        //textField
        textField.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 400, height: 50))
            make.top.equalTo(view).offset(75)
            make.left.equalTo(view).offset(25)
            make.right.equalTo(view).offset(-25)
            }
        //textLabelVolume
        textLabelVolume.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 150, height: 25))
            make.centerX.equalTo(view)
            make.centerY.equalTo(buttonStop).offset(50)
            }
        //buttonStop
        buttonStop.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerX.equalTo(view).offset(75)
            make.centerY.equalTo(progressBar).offset(100)
            }
        //buttonMute
        buttonMute.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerX.equalTo(view).offset(0)
            make.centerY.equalTo(buttonStop).offset(150)
            }
        //buttonPlayOrPause
        buttonPlayOrPause.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerX.equalTo(view).offset(-75)
            make.centerY.equalTo(progressBar).offset(100)
            }
        }
    }

    private func setupTextLabelProgress() {
        textLabelProgress.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textLabelProgress.backgroundColor = .none
        textLabelProgress.textAlignment = .center
        textLabelProgress.text = "0 : 0"
        self.view.addSubview(textLabelProgress)
    }

    private func setupTextField() {
        textField.backgroundColor = #colorLiteral(red: 0.7783591678, green: 0.7783591678, blue: 0.7783591678, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.5553307315, green: 0.5553307315, blue: 0.5553307315, alpha: 1)
        textField.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textField.text = "add your URL .mp3"
        textField.borderStyle = .roundedRect
        textField.clearsOnBeginEditing = true
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(textField)
    }

    private func setupVolumeSlider() {
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 100
        volumeSlider.setValue(Float(volumeDefault), animated: true)
        player.player.volume = volumeSlider.value / 100
        volumeSlider.addTarget(self, action: #selector(sliderActionVolume), for: .allTouchEvents)
        self.view.addSubview(volumeSlider)
    }

    private func setupTextLabelVolume() {
        textLabelVolume.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textLabelVolume.backgroundColor = .none
        textLabelVolume.text = "Volume \(Int(volumeDefault))%"
        textLabelVolume.textAlignment = .center
        self.view.addSubview(textLabelVolume)
    }

    private func setupButtonStop() {
        buttonStop.setBackgroundImage(imageStop, for: .normal)
        buttonStop.setTitleColor(.black, for: .normal)
        buttonStop.backgroundColor = .none
        buttonStop.addTarget(self, action: #selector(buttonActionStop), for: .touchUpInside)
        self.view.addSubview(buttonStop)
    }

    private func setupButtonMute() {
        buttonMute.setBackgroundImage(imageVolumeUP, for: .normal)
        buttonMute.setTitleColor(.black, for: .normal)
        buttonMute.backgroundColor = .none
        buttonMute.addTarget(self, action: #selector(buttonMuteAction), for: .touchUpInside)
        self.view.addSubview(buttonMute)
    }

    private func setupButtonPlayOrPause() {
        buttonPlayOrPause.setBackgroundImage(imagePlay, for: .normal)
        buttonPlayOrPause.setTitleColor(.black, for: .normal)
        buttonPlayOrPause.backgroundColor = .none
        buttonPlayOrPause.addTarget(self, action: #selector(buttonActionPlayOrPause), for: .touchUpInside)
        self.view.addSubview(buttonPlayOrPause)
    }

    @objc func buttonActionPlayOrPause(sender: UIButton!) {
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
            player.initPlayer(url: testURL)
            buttonPlayPause()
        } else {
            player.initPlayer(url: url!)
            buttonPlayPause()
        }
    }

    @objc func buttonActionStop(sender: UIButton!) {
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

    @objc func sliderActionVolume(sender: UISlider!) {
        player.player.volume = volumeSlider.value / 100
        textLabelVolume.text = "Volume \(Int(volumeSlider.value))%"
        if player.player.volume == 0 {
            buttonMute.setBackgroundImage(imageVolumeDOWN, for: .normal)
        } else {
            buttonMute.setBackgroundImage(imageVolumeUP, for: .normal)
        }
    }

    @objc func buttonMuteAction(sender: UIButton!) {
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
