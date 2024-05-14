//
//  MovieCD+CoreDataProperties.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//
//

import Foundation
import CoreData


extension MovieCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCD> {
        return NSFetchRequest<MovieCD>(entityName: "MovieCD")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var id: Int64
    @NSManaged public var originalTitle: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?

}

extension MovieCD : Identifiable {

}
