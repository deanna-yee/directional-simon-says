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
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeInteger(score, forKey: "score")
        aCoder.encodeInteger(rank, forKey: "rank")
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
        name = aDecoder.decodeObjectForKey("name") as! String
        score = aDecoder.decodeIntegerForKey("score")
        rank = aDecoder.decodeIntegerForKey("rank")
        
        super.init()
    }
}
