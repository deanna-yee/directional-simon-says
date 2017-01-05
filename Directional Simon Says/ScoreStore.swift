//
//  ScoreStore.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/13/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class ScoreStore {
    
    var topTenTapScores = [Score]()
    
    var topTenSwipeScores = [Score]()
    
    let tapScoreArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("tapScores.archive")
    }()
    
    let swipeScoreArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("swipeScores.archive")
    }()
    
    //creates score for Tap and puts it in the array
    func createTapScore(_ name: String, scoreInt: Int){
        let score = Score(name: name, score: scoreInt)
        
        topTenTapScores = createScores(score, scores: topTenTapScores)
    }
    
    func createSwipeScore(_ name: String, scoreInt: Int){
        let score = Score(name: name, score: scoreInt)
        
        topTenSwipeScores = createScores(score, scores: topTenSwipeScores)
    }
    //creates the scores for both tap and swipe
    func createScores(_ score: Score, scores: [Score]) ->[Score]{
        var scores = scores
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
        print("Saving Tap score to: \(tapScoreArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(topTenTapScores, toFile: tapScoreArchiveURL.path)
    }
    
    //lets you know that changes for swipe are being saved
    func saveSwipeChanges() -> Bool {
        print("Saving Swipe score to: \(swipeScoreArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(topTenTapScores, toFile: swipeScoreArchiveURL.path)

    }
    
    //Pushes the score onto the array and then sorts the array
    func organizeRanks(_ score: Score, scores:[Score]) -> [Score]{
        var scores = scores
        scores.append(score)
        scores.sort(by: {$0.score > $1.score})
        editRanks(scores)
        return scores
        
    }
    
    //Makes sure the scores all have the correct rank
    func editRanks(_ scores: [Score]){
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
        if let archivedTapScores = NSKeyedUnarchiver.unarchiveObject(withFile: tapScoreArchiveURL.path) as? [Score] {
            topTenTapScores += archivedTapScores
        }
        if let archivedSwipeScores = NSKeyedUnarchiver.unarchiveObject(withFile: swipeScoreArchiveURL.path) as? [Score] {
            topTenTapScores += archivedSwipeScores
        }
    }
    
}
