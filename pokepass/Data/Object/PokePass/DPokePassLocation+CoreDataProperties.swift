//
//  DPokePassLocation+CoreDataProperties.swift
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

extension DPokePassLocation {

    @NSManaged var latitude: Double
    @NSManaged var longitude: UNKNOWN_TYPE
    @NSManaged var locationProject: DPokePassProject?

}
