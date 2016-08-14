//
//  DPokePassProject+CoreDataProperties.swift
//  pokepass
//
//  Created by zero on 8/14/16.
//  Copyright © 2016 iturbide. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension DPokePassProject {

    @NSManaged var name: String?
    @NSManaged var projectLocations: NSOrderedSet?

}
