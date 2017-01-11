//
//  SwipeSimonSaysViewController.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/10/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class SwipeSimonSaysViewController: UIViewController {
    
    //shows the arrows when it is in the pattern and to swipe
    @IBOutlet weak var down: UIImageView!
    @IBOutlet weak var up: UIImageView!
    @IBOutlet weak var left: UIImageView!
    @IBOutlet weak var right: UIImageView!
    
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
    
    //creates a simon says object
    let simonSays = SimonSays()
    
    //displays the pattern and then shows all the buttons
    func displayPattern(){
        startButton.isHidden = true
        down.isHidden = true
        up.isHidden = true
        left.isHidden = true
        right.isHidden = true
        status.isHidden = true
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time){
            self.showPattern()
            self.delayShowAllButtons()
        }

    }
    
    //shows the score and checks to see if the game is over
    func checkStatus(){
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time){
            self.score.text = "Score: \(self.simonSays.score)"
            if self.simonSays.gameIsOver {
                print("game Over")
                self.status.text = "Game Over"
                self.down.isHidden = true
                self.up.isHidden = true
                self.left.isHidden = true
                self.right.isHidden = true
                self.gameOver.isHidden = false
            }
        }
        
    }
    
    //shows all the arrows so that they can be pressed
    func showAllArrowButtons(){
        down.alpha = 1.0
        down.isHidden = false
        down.isHighlighted = false
        up.alpha = 1.0
        up.isHidden = false
        up.isHighlighted = false
        right.alpha = 1.0
        right.isHidden = false
        right.isHighlighted = false
        left.alpha = 1.0
        left.isHighlighted = false
        left.isHidden = false
        status.isHidden = false
        simonSays.yourTurn = true
        enableSwipeGestureInImages()
    }
    
    
    //determines whether it is the your turn or showing the pattern
    func ifYourTurn(_ direction: Direction){
        if simonSays.yourTurn {
            simonSays.checkPattern(direction)
            checkStatus()
        }
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time){
            self.down.isHighlighted = false
            self.right.isHighlighted = false
            self.up.isHighlighted = false
            self.left.isHighlighted = false
            if !self.simonSays.yourTurn {
                self.disableGestureInImages()
                self.displayPattern()
            }
        }
        
    }
    
    //disable swipe so the you can't swipe when it is not your turn
    func disableGestureInImages(){
        down.isUserInteractionEnabled = false
        up.isUserInteractionEnabled = false
        right.isUserInteractionEnabled = false
        left.isUserInteractionEnabled = false
    }
    
    //allow swipes when it is your turn
    func enableSwipeGestureInImages(){
        down.isUserInteractionEnabled = true
        right.isUserInteractionEnabled = true
        left.isUserInteractionEnabled = true
        up.isUserInteractionEnabled = true
    }
    
    //causes the arrows to blink
    func blink(_ t: Double, image: UIImageView){
        image.alpha = 1.0
        let delay = t * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time){
            image.alpha = 0.0
        }
        
    }
    
    //goes to the array and shows the pattern
    func showPattern(){
        simonSays.createPattern()
        var indexes = (0..<simonSays.patternAmount).makeIterator()
        while let i = indexes.next(){
            
            let delay = Double(i) * Double(NSEC_PER_SEC)
            let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: time){
                self.getPattern(i)
            }
            if i == (simonSays.patternAmount - 1){
                simonSays.yourTurn = true
            }
        }
        
        
    }
    
    //determines whether the arrow is hidden or not
    func getPattern(_ i: Int){
        switch simonSays.pattern[i] {
        case Direction.down:
            up.isHidden = true
            left.isHidden = true
            right.isHidden = true
            down.isHidden = false
            blink(0.5, image: self.down)
        case Direction.left:
            down.isHidden = true
            up.isHidden = true
            right.isHidden = true
            left.isHidden = false
            blink(0.5, image: self.left)
        case Direction.right:
            down.isHidden = true
            up.isHidden = true
            left.isHidden = true
            right.isHidden = false
            blink(0.5, image: self.right)
        case Direction.up:
            down.isHidden = true
            left.isHidden = true
            right.isHidden = true
            up.isHidden = false
            blink(0.5, image: self.up)
        }
        
    }
    
    //puts a delay for all the buttons to be shown
    func delayShowAllButtons(){
        let delay = Double(simonSays.patternAmount/2 + simonSays.patternAmount) * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time){
            self.showAllArrowButtons()
        }
    }
    
    //Sends a Direction of right when the arrow is swiped right
    func rightSwipe(_ sender: UISwipeGestureRecognizer){
        right.isHighlighted = true
        ifYourTurn(Direction.right)
    }
    
    //Sends a Direction of left when the arrow is swiped left
    func leftSwipe(_ sender: UISwipeGestureRecognizer){
        left.isHighlighted = true
        ifYourTurn(Direction.left)
    }
    
    //Sends a Direction of up when the arrow is swiped up
    func upSwipe(_ sender: UISwipeGestureRecognizer){
        up.isHighlighted = true
        ifYourTurn(Direction.up)
    }
    
    //Sends a Direction of down when the arrow is swiped down
    func downSwipe(_ sender: UISwipeGestureRecognizer){
        down.isHighlighted = true
        ifYourTurn(Direction.down)
    }

    //starts the game of simon says
    @IBAction func start(_ sender: AnyObject) {
        simonSays.score = 0
        displayPattern()
    }
    

    
    //passes information to the final score view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SwipeContinue" {
            let finalViewController = segue.destination as! FinalScoreSwipeViewController
            finalViewController.score = simonSays.score
            finalViewController.scoreStore = scoreStore
        }
        
    }
    
    //hides information that doesn't need to be shown in the beginning
    override func viewDidLoad() {
        super.viewDidLoad()
        status.isHidden = true
        gameOver.isHidden = true
        //swipe recognizer to determine which direction you swiped
        let rightSwipeRec = UISwipeGestureRecognizer(target:self, action:#selector(SwipeSimonSaysViewController.rightSwipe(_:)))
        let leftSwipeRec = UISwipeGestureRecognizer(target:self, action: #selector(SwipeSimonSaysViewController.leftSwipe(_:)))
        let upSwipeRec = UISwipeGestureRecognizer(target:self, action: #selector(SwipeSimonSaysViewController.upSwipe(_:)))
        let downSwipeRec = UISwipeGestureRecognizer(target:self, action: #selector(SwipeSimonSaysViewController.downSwipe(_:)))
        rightSwipeRec.direction = .right
        leftSwipeRec.direction = .left
        downSwipeRec.direction = .down
        upSwipeRec.direction = .up
        down.addGestureRecognizer(downSwipeRec)
        up.addGestureRecognizer(upSwipeRec)
        left.addGestureRecognizer(leftSwipeRec)
        right.addGestureRecognizer(rightSwipeRec)
        
    }
    
    
}
