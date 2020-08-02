//
//  ViewController.swift
//  Scribe
//
//  Created by Boyang Zhang on 5/8/20.
//  Copyright © 2020 Boyang Zhang. All rights reserved.
//

import UIKit
import Speech
import AVFoundation


class ViewController: UIViewController, AVAudioPlayerDelegate {


    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    @IBOutlet weak var transcriptionTextField: UITextView!
    var audioPlay: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activitySpinner.isHidden = true
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                if let path = Bundle.main.url(forResource: "test", withExtension: "mp3"){
                    do{
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlay = sound
                        self.audioPlay.delegate = self
                        sound.play()
                        
                        
                        
                    } catch{
                      print("error")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request){(result, error) in
                        if let error = error{
                            print("There was an error:\(error)")
                        } else {
                            print(result?.bestTranscription.formattedString)
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                }
                
            }
        }
    }
    
    
    @IBAction func playButtonPressed(_ sender: Any) {
        
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
        
        
        
        
        
        
        
        
    }
    

}

