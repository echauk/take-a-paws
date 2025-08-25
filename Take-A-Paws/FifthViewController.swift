//
//  FifthViewController.swift
//  dog4
//
//  Created by Eshani Chauk on 10/19/19.
//  Copyright © 2019 Eshani Chauk. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer: AVAudioPlayer!

class FifthViewController: UIViewController
{
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var composerName: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        songName.text = list[myIndex]
        composerName.text = composers[myIndex]
        
        do
        {
            var name = list[myIndex]
            if (name == "Musetta's Song")
            {
                name = "Musettas Song"
            }
            let audioPath = Bundle.main.url(forResource: name, withExtension: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: audioPath!)
        }
        catch
        {
            // error
        }
    }

    @IBAction func playTapped(_ sender: Any)
    {
        if audioPlayer.isPlaying == false
        {
            audioPlayer.play()
        }
    }
    
    @IBAction func stopTapped(_ sender: Any)
    {
        if audioPlayer.isPlaying == true
        {
            audioPlayer.stop()
        }
    }
    
    @IBAction func addToPlaylist(_ sender: Any)
    {
        if audioPlayer.isPlaying == true
        {
            audioPlayer.stop()
        }
        
        var name = list[myIndex]
        if (name == "Musetta's Song")
        {
            name = "Musettas Song"
        }
        
        if (!(playlist.contains(name)))
        {
            playlist.append(name)
        }
    }
    
}
