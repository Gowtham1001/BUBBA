//
//  StatViewController.swift
//  Bubba
//
//  Created by Shrreya Ram on 21/04/23.
//

import UIKit

class StatViewController: UIViewController , SecondViewControllerDelegate{
    
    @IBOutlet var desc: UILabel!
    @IBOutlet var percent: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToQues", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToQues" {
            let destinationVC = segue.destination as! PHQ___9_TestViewController
            destinationVC.delegate = self
            
        }
    }
    
    func secondViewControllerDidFinish(totalScore : Int) {
        let perc: Float = (Float(totalScore) / Float(27)) * 100.0
        percent.text = String(format: "%.1f", perc)+"%"
        
        if totalScore >= 1 && totalScore <= 4{
            desc.text = "Minimal depression"
        }
        else if totalScore >= 5 && totalScore <= 9{
            desc.text = "Mild depression"
        }
        else if totalScore >= 10  && totalScore <= 14{
            desc.text = "Moderate depression"
        }
        else if totalScore >= 15 && totalScore <= 19{
            desc.text = "Moderately severe depression"
        }
        else if totalScore >= 20 && totalScore <= 27{
            desc.text = "Severe depression"
        }
    }
    
    

    
}
