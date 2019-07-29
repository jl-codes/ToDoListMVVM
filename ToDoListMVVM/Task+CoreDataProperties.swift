//
//  Task+CoreDataProperties.swift
//  ToDoListMVVM
//
//  Created by MCS on 7/21/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData

extension Task {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
    return NSFetchRequest<Task>(entityName: "Task")
  }
  
  @NSManaged public var taskDetails: String?
  
}
