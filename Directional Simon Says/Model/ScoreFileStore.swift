//
//  ScoreStore.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/13/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class ScoreFileStore {
    
    var topTenTapScores = [Score]()
    
    var topTenSwipeScores = [Score]()
    
    let tapScoreArchiveURL: NSURL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("tapScores.archive") as NSURL
    }()
    
    let swipeScoreArchiveURL: NSURL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("swipeScores.archive") as NSURL
    }()
    
    //creates score for Tap and puts it in the array
    func createTapScore(name: String, scoreInt: Int) -> Score {
        let score = Score(name: name, score: scoreInt)
        
        topTenTapScores = createScores(score: score, scores: topTenTapScores)
        return score
    }
    
    func createSwipeScore(name: String, scoreInt: Int) -> Score {
        let score = Score(name: name, score: scoreInt)
        
        topTenSwipeScores = createScores(score: score, scores: topTenSwipeScores)
        return score
    }
    
    //creates the top 10 scores list
    func createScores(score: Score,  scores: [Score]) ->[Score]{
        var scores = scores
        if scores.count < 10{
            scores = organizeRanks(score: score, scores: scores)
        } else if let lastScore = scores.last?.score, score.score < lastScore{
            scores.removeLast()
            scores = organizeRanks(score: score, scores: scores)
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
    func organizeRanks(score: Score, scores:[Score]) -> [Score]{
        var scores = scores
        scores.append(score)
        scores.sort(by: {$0.score > $1.score})
        editRanks(scores: scores)
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
        if let archivedTapScores = NSKeyedUnarchiver.unarchiveObject(withFile: tapScoreArchiveURL.path!) as? [Score] {
            topTenTapScores += archivedTapScores
        }
        if let archivedSwipeScores = NSKeyedUnarchiver.unarchiveObject(withFile: swipeScoreArchiveURL.path!) as? [Score] {
            topTenTapScores += archivedSwipeScores
        }
    }
    
}
