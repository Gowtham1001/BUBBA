//
//  TestQuestions.swift
//  Bubba
//
//  Created by Shrreya Ram on 29/04/23.
//

import Foundation

struct Ques{
    let title: String
}

struct TestQuestions {
    
    var queNumber = 0
    
    var sum = 0
    
    let questions = [
        Ques(
        title: "1. Little interest or pleasure in doing things"
        ),
        Ques(
        title: "2. Feeling down, depressed, or hopeless"
        ),
        Ques(
        title: "3. Trouble falling or staying asleep, or sleeping too much"
        ),
        Ques(
        title: "4. Feeling tired or having little energy"
        ),
        Ques(
        title: "5. Poor appetite or overeating"
        ),
        Ques(
        title: "6. Feeling bad about yourself or that you are a failure or have let yourself or your family down"
        ),
        Ques(
        title: "7. Trouble concentrating on things, such as reading the newspaper or watching television"
        ),
        Ques(
        title: "8. Moving or speaking so slowly that other people could have noticed. Or the opposite being so figety or restless that you have been moving around a lot more than usual"
        ),
        Ques(
        title: "9. Thoughts that you would be better off dead, or of hurting yourself"
        )
    ]
    
    func getQueTitle() -> String {
        if queNumber >= 9{
            return "END"
        }
        else{
            return questions[queNumber].title
        }
    }
    
    mutating func nextQue(userChoice: String) {
        
        var currentQues = questions[queNumber]
        
        if userChoice == "Not at all" {
            sum += 0
        } else if userChoice == "Several days" {
            sum += 1
        }else if userChoice == "More than half the days"{
            sum += 2
        }else if userChoice == "Nearly every day"{
            sum += 3
        }
        if queNumber <= 8{
            queNumber += 1
        }
    }
    
    mutating func getScore() -> Int{
        return sum
    }
    
}


