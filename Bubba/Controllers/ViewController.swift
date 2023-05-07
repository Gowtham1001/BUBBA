
//  ViewController.swift
//  Bubba
//
//  Created by Shrreya Ram on 21/04/23.


import UIKit
import SceneKit
import ARKit
import AVFoundation
import Speech

class ViewController: UIViewController, ARSCNViewDelegate {



    @IBOutlet var sceneView: ARSCNView!
    var chatManager = ChatManager()
    @IBOutlet weak var lb_speech: UILabel!
    @IBOutlet weak var view_color: UIView!
    @IBOutlet weak var btn_start: UIButton!

    
    let audioEngine = AVAudioEngine()
    let speechReconizer : SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task : SFSpeechRecognitionTask!
    var isStart : Bool = false
    let synthesizer = AVSpeechSynthesizer()


    // AR


    override func viewDidLoad() {
        super.viewDidLoad()

        let manScene = SCNScene(named: "art.scnassets/happy_bubba(1) (4) copy.scn")
        if let manNode = manScene?.rootNode.childNode(withName: "Armature", recursively: true)!{
            manNode.position  = SCNVector3(0, -1.2, -2)
            sceneView.scene.rootNode.addChildNode(manNode )
        }
        chatManager.delegate = self
    }



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate





    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user

    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay

    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required

    }





    // Speech Recognition

    func startSpeechRecognization(){
            let node = audioEngine.inputNode
            let recordingFormat = node.outputFormat(forBus: 0)
            node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
                self.request.append(buffer)
            }
            audioEngine.prepare()
            do {
                try audioEngine.start()
            } catch _ {}
            guard let myRecognization = SFSpeechRecognizer() else {
                return
            }
            task = speechReconizer?.recognitionTask(with: request, resultHandler: { (response, error) in
                guard let response = response else {
                    if error != nil {
                    }else {
                    }
                    return
                }

                let message = response.bestTranscription.formattedString
                self.lb_speech.text = message
                var lastString: String = ""
                for segment in response.bestTranscription.segments {
                    let indexTo = message.index(message.startIndex, offsetBy: segment.substringRange.location)
                    lastString = String(message[indexTo...])
                }
            })
        }
    func cancelSpeechRecognization() {
            task.finish()
            task.cancel()
            request.endAudio()
            audioEngine.stop()
            if audioEngine.inputNode.numberOfInputs > 0 {
                audioEngine.inputNode.removeTap(onBus: 0)
            }
    }

    @IBAction func btn_start_stop(_ sender: Any) {
            isStart = !isStart
            if isStart {
                startSpeechRecognization()
                btn_start.setImage(UIImage(named: "Vector (2)"), for: .normal)
                self.sceneView.scene.rootNode.childNode(withName: "Armature", recursively: true)?.removeFromParentNode()
                let new2ModelScene = SCNScene(named: "art.scnassets/vetti_bubba_v1.scn")
                if let new2ModelNode = new2ModelScene?.rootNode.childNode(withName: "Armature", recursively: true) {
                    new2ModelNode.position = SCNVector3(0, -1.2, -2)
                self.sceneView.scene.rootNode.addChildNode(new2ModelNode)}
            }else {
                cancelSpeechRecognization()
                btn_start.setImage(UIImage(named: "Vector (3)"), for: .normal)
                print(lb_speech.text!)
                chatManager.fetchChat(chat: lb_speech.text ?? "Hello")
            }
        }

}

extension ViewController: ChatManagerDelegate{

    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.voiceChat)
            try AVAudioSession.sharedInstance().setActive(true)
            try AVAudioSession.sharedInstance().setMode(AVAudioSession.Mode.measurement)
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)

        } catch let error {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }


    func didUpdateChat(_ chatManager: ChatManager, chat: String) {
        DispatchQueue.main.async {
            self.setupAudioSession()


            self.sceneView.scene.rootNode.childNode(withName: "Armature", recursively: true)?.removeFromParentNode()

            let newModelScene = SCNScene(named: "art.scnassets/talking_bubba(1)_v1.scn")
            if let newModelNode = newModelScene?.rootNode.childNode(withName: "Armature", recursively: true) {
                newModelNode.position = SCNVector3(0, -1.2, -2)
            self.sceneView.scene.rootNode.addChildNode(newModelNode)}


            print(chat)
            let utterance = AVSpeechUtterance(string: chat)
            let voice = AVSpeechSynthesisVoice(language: "en-IN")
            utterance.voice = voice
            self.synthesizer.speak(utterance)
            

        }
        
    }



    func didFailWithError(error: Error) {
        print(error)
    }

}



