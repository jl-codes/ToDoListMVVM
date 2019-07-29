//
//  TaskListViewModel.swift
//  ToDoListMVVM
//
//  Created by MCS on 7/21/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData

public class TaskListViewModel {
  let manager = CoreDataManager()
  var tasks:[Task] = []
  var taskDetails: String?
  
//  var isFirstRun: Bool {
//    get {
//      return !UserDefaults.standard.bool(forKey: "isNotFirstRun")
//    } set {
//      UserDefaults.standard.set(!newValue, forKey: "isNotFirstRun")
//    }
//  }
  
//  init(tasks: [Task] = []) {
//    self.tasks = tasks
//  }
  
//  func initialTasks() {
//    guard isFirstRun else { return }
//    createNewTask(with: "Task 1")
//    createNewTask(with: "Task 2")
//    createNewTask(with: "Task 3")
//    createNewTask(with: "Task 4")
//    createNewTask(with: "Task 5")
//
//    save()
//    isFirstRun = false
//  }
  
  func createNewTask(with taskDetails: String) -> Task? {
    guard let task = manager.createNewTask(with: taskDetails) else { return nil }
    task.taskDetails = taskDetails
    tasks.append(task)
    return task
  }
  
  func update(at index: Int, with newTaskDetails: String) -> Task {
    tasks[index].taskDetails = newTaskDetails
    return tasks[index]
  }
  
  func delete(at index: Int) -> [Task]? {
    guard let task = getTask(at: index) else { return nil }
    manager.delete(task: task)
    tasks.remove(at: index)
    return tasks
  }
  
  func getTaskList() -> [Task] {
    return tasks
  }
  
  func getTaskList(named taskDetails: String) -> [Task] {
    let taskList = manager.getAllTasks(named: taskDetails)
    return taskList
  }
  
  func getTaskCount() -> Int {
    return getTaskList().count
  }
  
  func getTask(at index: Int) -> Task? {
    guard index >= 0 && index < tasks.count else { return nil }
    return tasks[index]
  }
  
//  func getViewModel(for index: Int) -> TaskListViewModel? {
//    return TaskListViewModel(tasks: tasks)
//  }
  
  func save() {
    manager.save()
  }
}
