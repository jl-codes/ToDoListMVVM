//
//  CoreDataManager.swift
//  ToDoListMVVM
//
//  Created by MCS on 7/19/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
  
 // private var tasks: [Task] = []
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "TaskModel")
    container.loadPersistentStores { description, error in
 //     print(description)
 //     print(error)
    }
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }



  @discardableResult
  func createNewTask(with taskName: String) -> Task? {
    guard let details = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return nil }
    let task = Task(entity: details, insertInto: context)
   // task.task = taskName
   // tasks.append(task)
    return task
  }
  
//  func update(task: Task, with newTask: String) -> Task {
//    task.task = newTask
//   // print(getAllTasks())
//    return task
//  }
  
  func delete(task: Task) {
    context.delete(task)
  //  tasks.remove(at: index)
  }
  
  func save() {
    guard context.hasChanges else { return }
    try? context.save()
  }
  
  func getAllTasks(named taskDetails: String) -> [Task] {
    let request: NSFetchRequest<Task> = Task.fetchRequest()
    request.predicate = NSPredicate(format: "taskDetails=%@", taskDetails)
    do {
      let tasks = try context.fetch(request)
      return tasks
    } catch {
      return []
    }
  }
  
  
}
