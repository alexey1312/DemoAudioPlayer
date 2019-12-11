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
    var timer: Timer?

    //image buttons
    let imagePlay = UIImage(#imageLiteral(resourceName: "ic_play_arrow_48px")).withTintColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
    let imagePause = UIImage(#imageLiteral(resourceName: "ic_pause_48px")).withTintColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
    let imageStop = UIImage(#imageLiteral(resourceName: "ic_stop_48px")).withTintColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
    let imageVolumeUP = UIImage(#imageLiteral(resourceName: "ic_volume_up_48px")).withTintColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
    let imageVolumeDOWN = UIImage(#imageLiteral(resourceName: "ic_volume_off_48px")).withTintColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))

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

        //test url init
        player.initPlayer(url: tasteURL)

        //init textField
        setupTextField()

        //init textLabelProgress and progress
        textLabelProgress.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textLabelProgress.backgroundColor = .none
        textLabelProgress.textAlignment = .center
        textLabelProgress.text = "0 : 0"

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
        self.progressBar.progress =
            Float(CMTimeGetSeconds(self.player.player.currentTime()) / CMTimeGetSeconds(self.player.availableDuration()))

        self.textLabelProgress.text =
            "\(Int(CMTimeGetSeconds(self.player.player.currentTime()))) : \(Int(CMTimeGetSeconds(self.player.availableDuration())))"
        }

        self.view.addSubview(textLabelProgress)
        textLabelProgress.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 150, height: 25))
            make.centerX.equalTo(view)
            make.centerY.equalTo(textField).offset(125)
        }

        self.view.addSubview(progressBar)
        progressBar.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(250)
            make.left.equalTo(view).offset(25)
            make.right.equalTo(view).offset(-25)
            make.centerX.equalTo(view)
        }

        //init buttonPlayOrPause
        setupButtonPlayOrPause()

        //init buttonStop
        setupButtonStop()

        //init buttonMute
        setupButtonMute()

        //init textLabelVolume
        setupTextLabelVolume()
        //init volumeSlider
        setupVolumeSlider()
    }

    private func setupTextField() {
        textField.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.text = "add your URL .mp3"
        textField.borderStyle = .roundedRect
        textField.clearsOnBeginEditing = true
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 400, height: 50))
            make.top.equalTo(view).offset(75)
            make.left.equalTo(view).offset(25)
            make.right.equalTo(view).offset(-25)
        }
    }

    private func setupVolumeSlider() {
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 100
        volumeSlider.setValue(15, animated: true)
        player.player.volume = volumeSlider.value
        volumeSlider.addTarget(self, action: #selector(sliderActionVolume), for: .allTouchEvents)
        self.view.addSubview(volumeSlider)
        volumeSlider.snp.makeConstraints { (make) in
            make.top.equalTo(textLabelVolume).offset(25)
            make.left.equalTo(view).offset(50)
            make.right.equalTo(view).offset(-50)
            make.centerX.equalTo(view)
        }
    }

    private func setupTextLabelVolume() {
        textLabelVolume.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textLabelVolume.backgroundColor = .none
        textLabelVolume.text = "Volume 15%"
        textLabelVolume.textAlignment = .center
        self.view.addSubview(textLabelVolume)
        textLabelVolume.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 150, height: 25))
            make.centerX.equalTo(view)
            make.centerY.equalTo(buttonStop).offset(50)
        }
    }

    private func setupButtonStop() {
        buttonStop.setBackgroundImage(imageStop, for: .normal)
        buttonStop.setTitleColor(.black, for: .normal)
        buttonStop.backgroundColor = .none
        buttonStop.addTarget(self, action: #selector(buttonActionStop), for: .touchUpInside)
        self.view.addSubview(buttonStop)
        buttonStop.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerX.equalTo(view).offset(75)
            make.centerY.equalTo(progressBar).offset(100)
        }
    }

    private func setupButtonMute() {
        buttonMute.setBackgroundImage(imageVolumeUP, for: .normal)
        buttonMute.setTitleColor(.black, for: .normal)
        buttonMute.backgroundColor = .none
        buttonMute.addTarget(self, action: #selector(buttonMuteAction), for: .touchUpInside)
        self.view.addSubview(buttonMute)
        buttonMute.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerX.equalTo(view).offset(0)
            make.centerY.equalTo(buttonStop).offset(150)
        }
    }

    private func setupButtonPlayOrPause() {
        buttonPlayOrPause.setBackgroundImage(imagePlay, for: .normal)
        buttonPlayOrPause.setTitleColor(.black, for: .normal)
        buttonPlayOrPause.backgroundColor = .none
        buttonPlayOrPause.addTarget(self, action: #selector(buttonActionPlayOrPause), for: .touchUpInside)
        self.view.addSubview(buttonPlayOrPause)
        buttonPlayOrPause.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerX.equalTo(view).offset(-75)
            make.centerY.equalTo(progressBar).offset(100)
        }
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

    @objc func sliderActionVolume(sender: UISlider!) {
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
