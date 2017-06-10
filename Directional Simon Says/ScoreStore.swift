//
//  ScoreStore.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/13/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class ScoreStore {
    
    var topTenTapScores = [Score]()
    
    var topTenSwipeScores = [Score]()
    
    let tapScoreArchiveURL: NSURL = {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("tapScores.archive")!
    }()
    
    let swipeScoreArchiveURL: NSURL = {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("swipeScores.archive")!
    }()
    
    //creates score for Tap and puts it in the array
    func createTapScore(name: String, scoreInt: Int) -> Score {
        let score = Score(name: name, score: scoreInt)
        
        topTenTapScores = createScores(score, scores: topTenTapScores)
        return score
    }
    
    func createSwipeScore(name: String, scoreInt: Int) -> Score {
        let score = Score(name: name, score: scoreInt)
        
        topTenSwipeScores = createScores(score, scores: topTenSwipeScores)
        return score
    }
    //creates the scores for both tap and swipe
    func createScores(score: Score, var scores: [Score]) ->[Score]{
        if scores.count < 10{
            scores = organizeRanks(score, scores: scores)
        } else if score.score < scores.last?.score{
            scores.removeLast()
            scores = organizeRanks(score, scores: scores)
        }
        return scores
    
    }
    
    //lets you know that changes for tap are being saved
    func saveTapChanges() -> Bool {
        print("Saving Tap score to: \(tapScoreArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(topTenTapScores, toFile: tapScoreArchiveURL.path!)
    }
    
    //lets you know that changes for swipe are being saved
    func saveSwipeChanges() -> Bool {
        print("Saving Swipe score to: \(swipeScoreArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(topTenTapScores, toFile: swipeScoreArchiveURL.path!)

    }
    
    //Pushes the score onto the array and then sorts the array
    func organizeRanks(score: Score, var scores:[Score]) -> [Score]{
        scores.append(score)
        scores.sortInPlace({$0.score > $1.score})
        editRanks(scores)
        return scores
        
    }
    
    //Makes sure the scores all have the correct rank
    func editRanks(scores: [Score]){
        for i in 0..<scores.count{
            if i == 0 {
                scores[i].rank = 1
            } else  {
                if scores[i].score == scores[i - 1].score{
                    scores[i].rank = scores[i - 1].rank
                } else if scores[i].score < scores[i - 1].score {
                    scores[i].rank = i + 1
                }
            }
        }
    }
    
    init() {
        if let archivedTapScores = NSKeyedUnarchiver.unarchiveObjectWithFile(tapScoreArchiveURL.path!) as? [Score] {
            topTenTapScores += archivedTapScores
        }
        if let archivedSwipeScores = NSKeyedUnarchiver.unarchiveObjectWithFile(swipeScoreArchiveURL.path!) as? [Score] {
            topTenTapScores += archivedSwipeScores
        }
    }
    
}
