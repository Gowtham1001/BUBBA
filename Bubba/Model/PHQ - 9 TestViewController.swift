//
//  PHQ - 9 TestViewController.swift
//  Bubba
//
//  Created by Shrreya Ram on 29/04/23.
//

import UIKit


protocol SecondViewControllerDelegate: AnyObject {
    func secondViewControllerDidFinish(totalScore score: Int)
}

class PHQ___9_TestViewController: UIViewController {
    
    weak var delegate: SecondViewControllerDelegate?

    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
     
    var scores: Int = 0
    
    @IBOutlet weak var queLabel: UILabel!
    var testQuesion = TestQuestions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func choiceMade(_ sender: UIButton) {

        testQuesion.nextQue(userChoice: sender.titleLabel?.text ?? "Nil")
        updateUI()
    }
    
    func updateUI(){
        if testQuesion.getQueTitle() == "END"{
            scores = testQuesion.getScore()
            end(score: scores)
        }
        else{
            queLabel.text = testQuesion.getQueTitle()
        }
    }
    func end(score : Int){
        delegate?.secondViewControllerDidFinish(totalScore: score)
        self.dismiss(animated: true, completion: nil)
    }
    
}
