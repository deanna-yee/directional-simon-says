//
//  FinalScoreTapViewController.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/13/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class FinalScoreViewController: UIViewController, UITextFieldDelegate {
   
    //shows the score they got on the screen
    @IBOutlet weak var scoreLabel: UILabel!
    
    //name from the UITextField
    var name: String!
    
    //swipe or tap depending on the type of game you played
    var gameType: String!
    
    //Score from the SimonSaysViewController segue
    var score: Int!
    
    //scoreStore shared within the application
    var scoreStore : ScoreStore!
    
    //Dismiss keyboard by tapping the background
    @IBAction func backgroundTapped(sender: AnyObject) {
        view.endEditing(true)
    }
    

    //Gets the name from the UITextField
    @IBAction func getName(sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            name = text
        }
    }
    
    @IBAction func goToMain(sender: UIBarButtonItem){
        performSegue(withIdentifier: "gotoMain", sender: self)
    }
    
    //Dismiss keyboard by hitting return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //adds the score to the array
    func addScore(){
        if gameType == "tap"{
            scoreStore.createTapScore(name: name, scoreInt: score)
        }else{
            scoreStore.createSwipeScore(name: name, scoreInt: score)
        }
    }
    
    //Adds the score to the array and goes to the table view of the top ten
    override func prepare( for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Done" {
            if name != nil{
                addScore()
            }
            let topTenViewController = segue.destination as! Top10TableViewController
            topTenViewController.scoreStore = scoreStore
            topTenViewController.gameType = gameType
        } else if segue.identifier == "gotoMain" {
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
        if let score = score{
            scoreLabel.text = "Score: \(score)"
        }
       
    }
}
