//
//  TapSimonSaysViewController.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/10/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class TapSimonSaysViewController: UIViewController {
    
    //shows the button that needs to be tapped when it is your turn
    @IBOutlet weak var down: UIButton!
    @IBOutlet weak var up: UIButton!
    @IBOutlet weak var left: UIButton!
    @IBOutlet weak var right: UIButton!
    
    //starts the game
    @IBOutlet weak var startButton: UIButton!
    
    //shows the score
    @IBOutlet weak var score: UILabel!
    
    //show whether its your turn or game over
    @IBOutlet weak var status: UILabel!
    
    //pressed to continue to finalScore tap page
    @IBOutlet weak var gameOver: UIButton!
   
    //scoreStore shared within the application
    var scoreStore: ScoreFileStore!
    
    //creates a simon says object
    let simonSays = SimonSays()
        
    //displays the pattern and then shows all the buttons
    func displayPattern(){
        startButton.hidden = true
        down.hidden = true
        up.hidden = true
        left.hidden = true
        right.hidden = true
        status.hidden = true
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()){
            self.showPattern()
            self.delayShowAllButtons()
        }

    }
    
    //shows the score and checks to see if the game is over
    func checkStatus(){
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()){
            self.score.text = "Score: \(self.simonSays.score)"
            if self.simonSays.gameIsOver {
                print("game Over")
                self.status.text = "Game Over"
                self.down.hidden = true
                self.up.hidden = true
                self.left.hidden = true
                self.right.hidden = true
                self.gameOver.hidden = false
            }
        }
        
    }
    
    //shows all the arrows so that they can be pressed
    func showAllArrowButtons(){
        down.alpha = 1.0
        down.hidden = false
        up.alpha = 1.0
        up.hidden = false
        right.alpha = 1.0
        right.hidden = false
        left.alpha = 1.0
        left.hidden = false
        status.hidden = false
        simonSays.yourTurn = true
    }
    
    
    //determines whether it is the your turn or showing the pattern
    func ifYourTurn(direction: Direction){
        if simonSays.yourTurn {
            simonSays.checkPattern(direction)
            checkStatus()
        }
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()){
            if !self.simonSays.yourTurn {
                self.displayPattern()
            }
        }
        
    }
    
    //causes the arrows to blink
    func blink(t: Double, button: UIButton){
        button.alpha = 1.0
        let delay = t * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()){
            button.alpha = 0.0
        }
        
    }
    
    //goes to the array and shows the pattern
    func showPattern(){
        simonSays.createPattern()
        var indexes = (0..<simonSays.patternAmount).generate()
        while let i = indexes.next(){
            
            let delay = (Double(i) + 1) * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()){
                self.getPattern(i)
            }
            if i == (simonSays.patternAmount - 1){
                simonSays.yourTurn = true
            }
        }
        
        
    }
    
    //determines whether the arrow is hidden or not
    func getPattern(i: Int){
        switch simonSays.pattern[i] {
        case Direction.Down:
            up.hidden = true
            left.hidden = true
            right.hidden = true
            down.hidden = false
            blink(0.5, button: self.down)
        case Direction.Left:
            down.hidden = true
            up.hidden = true
            right.hidden = true
            left.hidden = false
            blink(0.5, button: self.left)
        case Direction.Right:
            down.hidden = true
            up.hidden = true
            left.hidden = true
            right.hidden = false
            blink(0.5, button: self.right)
        case Direction.Up:
            down.hidden = true
            left.hidden = true
            right.hidden = true
            up.hidden = false
            blink(0.5, button: self.up)
        default:
            break
        }
        
    }
    
    //puts a delay for all the buttons to be shown
    func delayShowAllButtons(){
        let delay = Double(simonSays.patternAmount * 2) * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()){
            self.showAllArrowButtons()
        }
    }

    //starts the game of simon says
    @IBAction func start(sender: AnyObject) {
        simonSays.score = 0
        displayPattern()
    }
    
    //checks to see if the down button is the correct button to press
    @IBAction func pressDown(sender: AnyObject) {
        ifYourTurn(Direction.Down)
        
    }
    
    //checks to see if the up button is the correct button to press
    @IBAction func pressUp(sender: AnyObject) {
        ifYourTurn(Direction.Up)
    }
    
    //checks to see if the left button is the correct button to press
    @IBAction func pressLeft(sender: AnyObject) {
        ifYourTurn(Direction.Left)
    }
    
    //checks to see if the right button is the correct button to press
    @IBAction func pressRight(sender: AnyObject) {
        ifYourTurn(Direction.Right)
    }
    
    //passes information to the final score view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Continue" {
            let finalViewController = segue.destinationViewController as! FinalScoreTapViewController
            finalViewController.score = simonSays.score
            finalViewController.scoreStore = scoreStore
        }
        
    }
    
    //hides information that doesn't need to be shown in the beginning
    override func viewDidLoad() {
        super.viewDidLoad()
        status.hidden = true
        gameOver.hidden = true
        
    }
    
    
}
