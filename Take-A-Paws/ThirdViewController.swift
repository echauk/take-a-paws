//
//  ThirdViewController.swift
//  dog4
//
//  Created by Eshani Chauk on 8/25/19.
//  Copyright © 2019 Eshani Chauk. All rights reserved.
//

// modified from The Swift Guy "How To Set Up An Alert In Xcode 8 (Swift 3.0)" https://www.youtube.com/watch?v=4EAGIiu7SFU
// modified from The Swift Guy "How To Create A Timer App In xCode 8 (Swift 3.0)" https://www.youtube.com/watch?v=fZx29HOcHzY
// modified from The Swift Guy "How To Make Countdown Timer App In Xcode 8 (Swift 3.0)" https://www.youtube.com/watch?v=iNEjh6zDUsg

import UIKit
import AVFoundation

class ThirdViewController: UIViewController, AVAudioPlayerDelegate
{
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var hoursInput: UILabel!
    @IBOutlet weak var minutesInput: UILabel!
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    
    var totalTime = 0, hours = 0, minutes = 0
    var counter = 0
    var currHours = 0, currMinutes = 0, currSeconds = 0
    
    var timer = Timer()
    
    
    @IBAction func slider1Changed(_ sender: UISlider)
    {
        hours = Int(sender.value)
        hoursInput.text = String(hours) + " hours"
    }
    
    @IBAction func slider2Changed(_ sender: UISlider)
    {
        minutes = Int(sender.value)
        minutesInput.text = String(minutes) + " minutes"
    }
    
    @IBAction func start(_ sender: Any)
    {
        totalTime = hours * 3600 + minutes * 60
        
        if (playlist.count == 0 && totalTime != 0)
        {
            createAlert(title: "Please add at least one song to your playlist", message: "")
        }
        else if (playlist.count != 0 && totalTime == 0)
        {
            createAlert(title: "Please set hours and/or minutes", message: "")
        }
        else if (playlist.count == 0 && totalTime == 0)
        {
            createAlert(title: "Please set hours and/or minutes and add at least one song to your playlist", message: "")
        }
        else
        {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ThirdViewController.action), userInfo: nil, repeats: true)
            
            startButton.isHidden = true
            resetButton.isHidden = false
            
            slider1.isHidden = true
            slider2.isHidden = true
            hoursInput.isHidden = true
            minutesInput.isHidden = true
            
            playThis(thisOne: playlist[counter])
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        counter += 1
        if(counter == playlist.count)
        {
            counter = 0
        }
        playThis(thisOne: playlist[counter])
    }
    
    func playThis(thisOne:String)
    {
        do
        {
            let audioPath = Bundle.main.url(forResource: thisOne, withExtension: ".mp3")!
            try audioPlayer = AVAudioPlayer(contentsOf: audioPath)
            audioPlayer.delegate = self
        }
        catch
        {
            // error
        }
        
        let session = AVAudioSession.sharedInstance()
        do
        {
            try session.setCategory(AVAudioSession.Category.playback)
        }
        catch
        {
            // error
        }
        
        audioPlayer.play()
    }
    
    @IBAction func reset(_ sender: Any)
    {
        timer.invalidate()
        audioPlayer.stop()
        
        totalTime = 0
        hours = 0
        minutes = 0
        
        timerLabel.text = "00:00"
        timerLabel.isHidden = true
        startButton.isHidden = false
        resetButton.isHidden = true
        
        slider1.isHidden = false
        slider1.setValue(0, animated: true)
        
        slider2.isHidden = false
        slider2.setValue(1, animated: true)
        
        hoursInput.isHidden = false
        hoursInput.text = "0 hours"
        
        minutesInput.isHidden = false
        minutesInput.text = "0 minutes"
    }
    
    @objc func action()
    {
        currHours = totalTime / 3600
        currMinutes = totalTime % 3600 / 60
        currSeconds = totalTime % 3600 % 60
        timerLabel.isHidden = false
        
        if (currHours < 10 && currMinutes < 10)
        {
            if(currSeconds < 10)
            {
                timerLabel.text = "0" + String(currHours) + ":0" + String(currMinutes) + ":0" + String(currSeconds)
            }
            else
            {
                timerLabel.text = "0" + String(currHours) + ":0" + String(currMinutes) + ":" + String(currSeconds)
            }
        }
        else if (currHours < 10 && currMinutes >= 10)
        {
            if(currSeconds < 10)
            {
                timerLabel.text = "0" + String(currHours) + ":" + String(currMinutes) + ":0" + String(currSeconds)
            }
            else
            {
                timerLabel.text = "0" + String(currHours) + ":" + String(currMinutes) + ":" + String(currSeconds)
            }
        }
        else if (currHours >= 10 && currMinutes < 10)
        {
            if(currSeconds < 10)
            {
                timerLabel.text = String(currHours) + ":0" + String(currMinutes) + ":0" + String(currSeconds)
            }
            else
            {
                timerLabel.text = String(currHours) + ":0" + String(currMinutes) + ":" + String(currSeconds)
            }
        }
        else if (currHours >= 10 && currMinutes >= 10)
        {
            if(currSeconds < 10)
            {
                timerLabel.text = String(currHours) + ":" + String(currMinutes) + ":0" + String(currSeconds)
            }
            else
            {
                timerLabel.text = String(currHours) + ":" + String(currMinutes) + ":" + String(currSeconds)
            }
        }
        
        totalTime -= 1
        
        if (totalTime == 0)
        {
            timer.invalidate()
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            
            timerLabel.isHidden = true
            startButton.isHidden = false
            resetButton.isHidden = true
            
            slider1.isHidden = false
            slider1.setValue(0, animated: true)
            
            slider2.isHidden = false
            slider2.setValue(1, animated: true)
            
            hoursInput.isHidden = false
            hoursInput.text = "0 hours"
            
            minutesInput.isHidden = false
            minutesInput.text = "0 minutes"
        }
    }
    
    override func viewDidLoad()
    {
        timerLabel.isHidden = true
        resetButton.isHidden = true
        super.viewDidLoad()
    }
    
    func createAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
