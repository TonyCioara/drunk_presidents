//
//  Inventory extensions.swift
//  drunk_presidents_frontend
//
//  Created by Tony Cioara on 2/10/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import CoreData

extension Quote {
    convenience init(context: NSManagedObjectContext) {
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Quote", in:
            context)!
        
        self.init(entity: entityDescription, insertInto: context)
    }
}

