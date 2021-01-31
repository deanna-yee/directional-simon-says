//
//  ScoreStore.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/13/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

import Foundation


class ScoreStore {
    
    var topTenTapScores = [Score]()
    
    var topTenSwipeScores = [Score]()
    

    func setScore(name: String, scoreInt: Int, scores:[Score]) -> Score{
        let score = Score()
        score.name = name
        score.score = Int64(scoreInt)
        score.rank = Int16(scores.count)
        return score
    }
    //creates score for Tap and puts it in the array
    func createTapScore(name: String, scoreInt: Int) {
        
        let score = setScore(name: name, scoreInt: scoreInt, scores: topTenTapScores)
        topTenTapScores = createScores(score: score, scores: topTenTapScores)
    }
    
    func createSwipeScore(name: String, scoreInt: Int){
        let score = setScore(name: name, scoreInt: scoreInt, scores: topTenSwipeScores)
        topTenSwipeScores = createScores(score: score, scores: topTenSwipeScores)
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
                    scores[i].rank = Int16(i + 1)
                }
            }
        }
    }

    
}
