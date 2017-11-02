//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by William Ko on 12/12/15.
//  Copyright © 2015 Will Ko. All rights reserved.
//

import AVFoundation
import UIKit

class PlaySoundsViewController: UIViewController {
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        audioEngine = AVAudioEngine()
        audioFile = try? AVAudioFile(forReading: recievedAudio.filePathUrl)
        audioPlayer = try? AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl)
        audioPlayer.enableRate = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioSpeed(rate: Float) {
        clearAudio()
        
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioPitch(pitch: Float) {
        clearAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try audioEngine.start()
        } catch _ {
        }
        
        audioPlayerNode.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioSpeed(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioSpeed(2.0)
    }
    
    
    @IBAction func playHighAudio(sender: UIButton) {
        playAudioPitch(1000)
        
    }
    
    @IBAction func playLowAudio(sender: UIButton) {
        playAudioPitch(-1000)
    }
    
    @IBAction func stopAlllAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }


    
}