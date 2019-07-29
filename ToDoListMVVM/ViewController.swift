//
//  ViewController.swift
//  ToDoListMVVM
//
//  Created by MCS on 7/18/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit
//import CoreData

class ViewController: UIViewController {
  
  @IBOutlet weak var toDoList: UITableView!
  
  //var stringArray = ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"]
  let viewModel = TaskListViewModel()
  //let manager = CoreDataManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    //viewModel.initialTasks()
    
    //manager.update(task: viewModel.getTask(at: 0), with: "Task 1")
    
    //viewModel.get
    toDoList.dataSource = self
    toDoList.delegate = self
    toDoList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    //viewModel.initialTasks()
    viewModel.createNewTask(with: "Task 1")
    viewModel.createNewTask(with: "Task 2")
    viewModel.createNewTask(with: "Task 3")
    viewModel.createNewTask(with: "Task 4")
    viewModel.createNewTask(with: "Task 5")
    
    print(viewModel.getTaskList())
    //print(viewModel.initialTasks)
    
    //toDoList.reloadData()
    
    //manager.save()
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getTaskCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.textLabel?.text = viewModel.getTask(at: indexPath.row)?.taskDetails
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    guard let nextViewModel = viewModel.getViewModel(for: indexPath.row) else {
//      return
//    }
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let nextViewController = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
  //  editViewController.stringToEdit = stringArray[indexPath.row]
  //  editViewController.delegate = self
    navigationController?.pushViewController(nextViewController, animated: true)
    DispatchQueue.main.async {
      self.toDoList.reloadData()
    }
  }
}

extension ViewController: EditViewControllerDelegate {
  func delete() {
    guard let deletedIndex = toDoList.indexPathForSelectedRow else { return }
    viewModel.delete(at: deletedIndex.row)
    toDoList.deleteRows(at: [deletedIndex], with: .automatic)
  }
  
  func update(to newTask: String) {
    guard let updatedIndex = toDoList.indexPathForSelectedRow else { return }
    viewModel.update(at: updatedIndex.row, with: newTask)
    toDoList.reloadRows(at: [updatedIndex], with: .automatic)
  }
}

