//
//  ScoreStore.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/13/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

import Foundation
import CoreData


class ScoreStore {
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SimonSays")
        container.loadPersistentStores{
            (description, error) in
            if let error = error{
                print("Error setting up Core Data \(error)")
            }
        }
        return container
    }()
    
    var topTenTapScores = [Score]()
    
    var topTenSwipeScores = [Score]()
    
    var selectedScores = [Score]()
    
    func chooseList(selected: Int){
        if selected == 0{
            selectedScores = topTenTapScores
        }else{
            selectedScores = topTenSwipeScores
        }
    }
    
    func save(context: NSManagedObjectContext){
        do {
            try context.save()
        }catch{
        
        }
    }
    
    func update(context: NSManagedObjectContext){
        if context.hasChanges{
            save(context: context)
        }
    }
    
    func delete(score: Score, context: NSManagedObjectContext){
        context.delete(score)
    }
    func setScore(name: String, scoreInt: Int, scores:[Score], gameType: String) -> Score{
        let context = persistentContainer.viewContext
        let score = Score(context: context)
        score.name = name
        score.gameType = gameType
        score.score = Int64(scoreInt)
        score.rank = Int16(scores.count)
        save(context: context)
        return score
    }
    //creates score for Tap and puts it in the array
    func createTapScore(name: String, scoreInt: Int) {
        
        let score = setScore(name: name, scoreInt: scoreInt, scores: topTenTapScores, gameType: "Tap")
        topTenTapScores = createScores(score: score, scores: topTenTapScores)
    }
    
    func createSwipeScore(name: String, scoreInt: Int){
        let score = setScore(name: name, scoreInt: scoreInt, scores: topTenSwipeScores, gameType: "Swipe")
        topTenSwipeScores = createScores(score: score, scores: topTenSwipeScores)
    }
    
    //creates the top 10 scores list
    func createScores(score: Score,  scores: [Score]) ->[Score]{
        var scores = scores
        if scores.count < 10{
            scores = organizeRanks(score: score, scores: scores)
        } else if let lastScore = scores.last?.score, score.score < lastScore{
            let context = persistentContainer.viewContext
            delete(score: scores.last!, context: context)
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
        let context = persistentContainer.viewContext
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
        update(context: context)
    }
    
    func fetchAllScores(completion: @escaping (Result<[Score], Error>) -> Void){
        let fetchRequest: NSFetchRequest<Score> = Score.fetchRequest()
        let sortByRanking = NSSortDescriptor(key: #keyPath(Score.rank), ascending: true)
        fetchRequest.sortDescriptors = [sortByRanking]
        let context = persistentContainer.viewContext
        context.perform {
            do{
                let allScores = try context.fetch(fetchRequest)
                completion(.success(allScores))
            }catch{
                completion(.failure(error))
            }
        }
    }
    
    func updateScoresLists(){
        fetchAllScores{
            (scoreResult) in
            switch scoreResult {
                case let .success(scores):
                    print(scores)
                    for score in scores{
                        if score.gameType == "Tap"{
                            self.topTenTapScores.append(score)
                        }else{
                            self.topTenSwipeScores.append(score)
                        }
                    }
                    self.editRanks(scores: self.topTenTapScores)
                    self.editRanks(scores: self.topTenSwipeScores)
                case .failure:
                    self.topTenTapScores.removeAll()
                    self.topTenSwipeScores.removeAll()
            }
        }
    }
    
}
