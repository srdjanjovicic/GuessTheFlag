//
//  ViewController.swift
//  Guess The Flag
//
//  Created by user151112 on 9.3.19..
//  Copyright © 2019. user151112. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var firstFlag: UIButton!
    @IBOutlet var secondFlag: UIButton!
    @IBOutlet var thirdFlag: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numberOfQuestionAsked = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        firstFlag.layer.borderWidth = 1
        secondFlag.layer.borderWidth = 1
        thirdFlag.layer.borderWidth = 1
        
        firstFlag.layer.borderColor = UIColor.lightGray.cgColor
        secondFlag.layer.borderColor = UIColor.lightGray.cgColor
        thirdFlag.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestio(action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(checkScore))
    }

    func askQuestio(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        firstFlag.setImage(UIImage(named: countries[0]), for: .normal)
        secondFlag.setImage(UIImage(named: countries[1]), for: .normal)
        thirdFlag.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        numberOfQuestionAsked += 1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let title: String
        let message: String
        let buttonTitle: String
        var showMistake = ""
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        }
        else {
            title = "Wrong"
            score -= 1
            showMistake = "That is \(countries[sender.tag].uppercased()) not \(countries[correctAnswer].uppercased())! \n"
        }
        
        if ( numberOfQuestionAsked == 10 ) {
            message = "You answered 10 questions with score \(score). Thats not bad, lets go again!";
            buttonTitle = "Go"
        }
        else {
            message = showMistake + "Your score is \(score)"
            buttonTitle = "Continue"

        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: askQuestio))
        present(ac, animated: true)
        
    }

    @objc func checkScore(){
        let ac = UIAlertController(title: "Score", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
}
