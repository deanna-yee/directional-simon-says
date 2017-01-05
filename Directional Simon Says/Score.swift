//
//  Score.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/13/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class Score: NSObject, NSCoding {
    //name connected to score
    let name: String
    //the score the person got
    let score: Int
    //the rank if in the top ten
    var rank: Int
    
    //Writes to data file
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(score, forKey: "score")
        aCoder.encode(rank, forKey: "rank")
    }
    
    //Initializer for Score
    init(name: String, score: Int){
        self.name = name
        self.score = score
        self.rank = 0
        super.init()
    }
    
    //Initializer to get info from data file
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        score = aDecoder.decodeInteger(forKey: "score")
        rank = aDecoder.decodeInteger(forKey: "rank")
        
        super.init()
    }
}
