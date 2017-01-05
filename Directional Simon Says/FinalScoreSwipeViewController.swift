//
//  FinalScoreSwipeViewController.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/13/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class FinalScoreSwipeViewController: UIViewController, UITextFieldDelegate {
   
    //shows the score they got on the screen
    @IBOutlet weak var scoreLabel: UILabel!
    
    //name from the UITextField
    var name: String!
    
    //Score from the TapSimonSaysViewController segue
    var score: Int!
    
    //scoreStore shared within the application
    var scoreStore : ScoreStore!
    
    //Dismiss keyboard by tapping the background
    @IBAction func backgroundTapped(_ sender: AnyObject) {
        view.endEditing(true)
    }
    

    //Gets the name from the UITextField
    @IBAction func getName(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            name = text
        }
    }
    
    //Dismiss keyboard by hitting return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //adds the score to the array
    func addScore(){
        scoreStore.createSwipeScore(name, scoreInt: score)
    }
    
    //Adds the score to the array and goes to the table view of the top ten
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SwipeDone" {
            if name != nil{
                addScore()
            }
            let topTenSwipeViewController = segue.destination as! SwipeTop10TableViewController
            topTenSwipeViewController.scoreStore = scoreStore
        } else if segue.identifier == "SwipeCancel"{
            let mainMenuViewController = segue.destination as! MainMenuViewController
            mainMenuViewController.scoreStore = scoreStore
        }
        
    }
    
    //dismiss keyboard when cancel or done is pressed
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
    
    //displays the score
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score!)"
    }
}
