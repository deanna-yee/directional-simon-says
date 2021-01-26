//
//  SimonSays.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/12/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

import Foundation

//The different directions
enum Direction: Int{
    case Up = 0
    case Right
    case Down
    case Left
    
    //returns the count of cases in Direction
    static let count: Int = Direction.Left.rawValue + 1
    
}

class SimonSays {
    
    //calculate score for either tap or swipe
    var score: Int
    
    //The amount of items in the pattern
    var patternAmount: Int
    
    //gets the index of the pattern
    var patternIndex: Int
    
    //Tells whether its your Turn or not
    var yourTurn: Bool
    
    var gameIsOver: Bool
    
    //stores the pattern that will be shown
    var pattern: [Direction]
    
    //Increments score whenever the whole pattern is correct
    func incrementScoreAndPattern(){
        score += 1
        patternAmount += 1
    }
    
    //checks to see if the direction pressed or swiped is correct
    func checkCurrentPatternPosition(player: Direction) -> Bool{
        if player == pattern[patternIndex] {
            return true
        } else {
            return false
        }
    }
    
    //checks the pattern
    func checkPattern(player: Direction){
        if checkCurrentPatternPosition(player: player) == true {
            if (patternIndex == (patternAmount - 1)) {
                incrementScoreAndPattern()
                endOfPattern()
                yourTurn = false
                
            } else{
                patternIndex += 1
            }
        }
        else {
            gameOver()
        }
    }
    
    //creates the pattern that will be shown
    func createPattern(){
        
        for _ in 0..<patternAmount{
            let randomDir = Int.random(in: 0..<Direction.count)
            if let direction = Direction(rawValue: randomDir){
                pattern.append(direction)
            }
        }
    }
    
    //resets everything
    func gameOver(){
        patternAmount = 1
        endOfPattern()
        gameIsOver = true
    }
    
    //resets patternIndex and pattern for a new pattern
    func endOfPattern(){
        patternIndex = 0
        pattern.removeAll()
    }
    
    //Initializer
    init(){
        score = 0
        patternAmount = 1
        pattern = [Direction]()
        patternIndex = 0
        yourTurn = false
        gameIsOver = false
    }
    
}
