# swift-transcription
Description: An easy implemenation of audio transcription in swift

Input: Audio file such as .mp3 file

Output: Transcription

# First step: set up view
Three essential components are: Title, Text space, Button, and Activity spinner. 

## Title and Text space
Title describes the purpose of this app. Title component is very simple. You can use a label in Swift to make it.You can center and horizontal alignment for the title.

<img src="https://raw.githubusercontent.com/boyangzhang1993/swift-transcription/master/ScreenShotTitle.png" width="250">

Text space is to display the final transcription results.So under your title, add a text field for it. 

<img src="https://raw.githubusercontent.com/boyangzhang1993/swift-transcription/master/Screen%20Shot%202020-08-02%20at%2012.05.04%20PM.png" width="250">

##

## Button and Activity spinner
Button is the main function of this app. If an user presses it, the app will make a transcription. 
Activity spinner plays a spinner animation to indicate the transcription process. 
First, the basic setup is also simple. You can use button in swift to make it and add any alignment you like.

<img src="https://raw.githubusercontent.com/boyangzhang1993/swift-transcription/master/ScreenShotButton.png" width="250">

Next, we need to add Text space, Activity spinner, and Button in viewcontroller. 
Right click the button and connect it to viewcontroller. 

<img src="https://raw.githubusercontent.com/boyangzhang1993/swift-transcription/master/Screen%20Shot%202020-08-02%20at%2011.57.48%20AM.png" width="250">

# Button functions
You could use the ViewController.swift file I posed in this github. 

The following part is to explain most parts of it. 

Inside the outlet, we first define three To-do functions. 
```
    @IBAction func playButtonPressed(_ sender: Any) {
        
        activitySpinner.isHidden = false # Show activity spinner
        activitySpinner.startAnimating()# Start animation of activity spinner
        requestSpeechAuth()# Start transcription
    }
```
First function is to show the hidden activitySpinner.
Second function is to start animation of activity spinner.

First and second function were already defined by Xcode. So we don't need to do anything. 

Third function is to start transcription. This function calls a mp3 file from local file and starts transcription. 
SFSpeechRecognizer is the main variable. We need to feed it with a path, and it will do the task. 

```
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
```

# Results 
Finally, when we press this button, activity spinner will start spin and swift can call SFSpeechRecognizer to detect the most likely transcription.

<img src="https://raw.githubusercontent.com/boyangzhang1993/swift-transcription/master/Screen%20Recording%202020-08-02%20at%2012.19.02%20PM.gif" width="250">

