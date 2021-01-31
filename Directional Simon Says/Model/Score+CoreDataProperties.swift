//
//  Score+CoreDataProperties.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 1/30/21.
//  Copyright © 2021 cisstudent. All rights reserved.
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

}

extension Score : Identifiable {

}
