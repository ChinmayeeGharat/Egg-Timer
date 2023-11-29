//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let softTime = 300
    let mediumTime = 420
    let hardTime = 720
    
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle
        
        if hardness == "Soft"{
            totalTime = softTime
        }
        else if hardness == "Medium"{
            totalTime = mediumTime
        }
        else {
            totalTime = hardTime
        }
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime{
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
