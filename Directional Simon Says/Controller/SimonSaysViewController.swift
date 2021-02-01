//
//  TapSimonSaysViewController.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/10/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class SimonSaysViewController: UIViewController {
    
   
    
    //shows the button that needs to be tapped when it is your turn
    @IBOutlet var directionButtons: [UIButton]!
    
    //starts the game
    @IBOutlet weak var startButton: UIButton!
    
    //shows the score
    @IBOutlet weak var score: UILabel!
    
    //show whether its your turn or game over
    @IBOutlet weak var status: UILabel!
    
    //pressed to continue to finalScore tap page
    @IBOutlet weak var gameOver: UIButton!
   
    //scoreStore shared within the application
    var scoreStore: ScoreStore!
    var gameType: String!
    var colors = [UIColor.green, UIColor.purple, UIColor.red, UIColor.blue]
    
    //creates a simon says object
    let simonSays = SimonSays()
        
    //displays the pattern and then shows all the buttons
    func displayPattern(){
        startButton.isHidden = true
        enableOrDisableButtons(enable: false)
        hideShowButtons(hidden: true, alpha: 0.0)
        showPattern()
    }
    
    func hideShowButtons(hidden: Bool, alpha: CGFloat){
        for directionButton in directionButtons{
            directionButton.isHidden = hidden
            directionButton.alpha = alpha
        }
    }
    
    //shows the score and checks to see if the game is over
    func checkStatus(){
        self.score.text = "Score: \(self.simonSays.score)"
        if self.simonSays.gameIsOver {
            self.status.text = "Game Over"
            hideShowButtons(hidden: true, alpha: 0.0)
            self.gameOver.isHidden = false
        }else if !simonSays.yourTurn{
            displayPattern()
        }
        
    }
    
    //Enable or Disable user interactions on buttons
    func enableOrDisableButtons(enable: Bool){
        for button in directionButtons{
            button.isUserInteractionEnabled = enable
        }
    }
    
    //shows all the arrows so that they can be pressed
    func showAllArrowButtons(){
        hideShowButtons(hidden: false, alpha: 1.0)
        enableOrDisableButtons(enable: true)
        status.isHidden = false
        simonSays.yourTurn = true
    }
    
    //causes the arrows to blink
    func blink(delay: Int, duration:Double, button: UIButton){
        button.isHidden = false
        button.alpha = 0.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(delay)){
            UIView.animate(withDuration: duration){
                button.alpha = 1.0
                button.backgroundColor = self.colors[button.tag]
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(delay)){
            UIView.animate(withDuration: duration){
                button.alpha = 0.0
                button.backgroundColor = UIColor.clear
            }
        }
    }
    func blinkColor(delay: Int, duration: Double, button: UIButton){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(delay)){
            UIView.animate(withDuration: duration){
                button.backgroundColor = self.colors[button.tag]
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(delay)){
            UIView.animate(withDuration: duration){
                button.backgroundColor = UIColor.clear
            }
        }
    }
    
    //goes through the array and shows the pattern
    func showPattern(){
        simonSays.createPattern()
        for i in 0..<simonSays.patternAmount{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(i)){
                self.getPattern(current: self.simonSays.pattern[i].rawValue)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(simonSays.patternAmount + 1)){
            self.simonSays.yourTurn = true
            self.showAllArrowButtons()

        }
    }
    
    //determines whether the arrow is hidden or not
    func getPattern(current direction: Int){
        for i in 0..<Direction.count{
            if i != direction{
                directionButtons[i].isHidden = true
            }else{
                blink(delay: 500, duration: 1, button: directionButtons[i])
            }
        }
    }

    //starts the game of simon says
    @IBAction func start(sender: UIButton) {
        simonSays.score = 0
        displayPattern()
    }
    
    //checks to see if the button pressed is the correct button to press
    @IBAction func pressDirection(sender: UIButton) {
        blinkColor(delay: 50, duration: 0.5, button: sender)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(500)){
            if let direction = Direction.init(rawValue: sender.tag){
                self.simonSays.checkPattern(player: direction)
                self.checkStatus()
            }
        }
    }
    

    
    //passes information to the final score view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Continue" {
            let finalViewController = segue.destination as! FinalScoreViewController
            finalViewController.score = simonSays.score
            finalViewController.scoreStore = scoreStore
        }
        
    }
    
    //hides information that doesn't need to be shown in the beginning
    override func viewDidLoad() {
        super.viewDidLoad()
        status.isHidden = true
        gameOver.isHidden = true
        enableOrDisableButtons(enable: false)
    }
}
