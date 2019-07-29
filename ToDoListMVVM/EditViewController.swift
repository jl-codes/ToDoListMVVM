//
//  EditViewController.swift
//  ToDoListMVVM
//
//  Created by MCS on 7/18/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

protocol EditViewControllerDelegate {
  func update(to newValue: String)
  func delete()
}

class EditViewController: UIViewController {

  @IBOutlet weak var editTextField: UITextField!
  
  var stringToEdit: String?
  var delegate: EditViewControllerDelegate?
  //let manager = CoreDataManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    editTextField.text = stringToEdit
  }
  
  @IBAction func update(_ sender: UIButton) {
    
    if sender.tag == 1 {
      if let updateString = editTextField.text {
        delegate?.update(to: updateString)
      //  manager.update(task: , with: updateString)
        //manager.save()
        navigationController?.popViewController(animated: true)
      }
    } else if sender.tag == 2 {
      delegate?.update(to: "Complete")
     // manager.update(task: , with: "\t--Complete--")
      //manager.save()
      navigationController?.popViewController(animated: true)
      delegate?.delete()
    }
  }
}
