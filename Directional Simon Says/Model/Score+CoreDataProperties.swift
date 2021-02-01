//
//  Score+CoreDataProperties.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 1/31/21.
//
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var name: String?
    @NSManaged public var rank: Int16
    @NSManaged public var score: Int64
    @NSManaged public var gameType: String?

}

extension Score : Identifiable {

}
