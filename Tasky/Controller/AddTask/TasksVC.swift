//
//  ViewController.swift
//  Tasky
//
//  Created by Its_official_Haryanvi on 29/11/22.
//

import UIKit

class TasksVC: UIViewController {
    
    @IBOutlet weak var tblTasks: UITableView!
    @IBOutlet weak var txtFldAddTask: UITextField!
    @IBOutlet weak var btnAddTask: UIButton!
    
    private let taskManager = TaskManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupUI()
    }
    
    @IBAction func addTaskBtnPressed(_ sender: UIButton)
    {
        if (self.btnAddTask.currentTitle == BtnTaskType.addTask.rawValue) {
            self.addTask()
        }
        
        if (self.btnAddTask.currentTitle == BtnTaskType.updateTask.rawValue) {
            self.updateTask()
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton)
    {
        self.logoutUser()
    }
}

extension TasksVC {
    
    private func setupUI()
    {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func addTask()
    {
        // Add Task
        if (txtFldAddTask.text?.isEmpty == false) {
            taskManager.addTask(taskName: TaskModel(name: txtFldAddTask.text!))
        }
        self.txtFldAddTask.text = nil
        self.tblTasks.reloadData()
        
        // Scroll TableView to Bottom
        if (self.taskManager.arrTasks.count >= 1) {
            self.tblTasks.scrollToRow(at: IndexPath(row: self.taskManager.arrTasks.count - 1, section: 0),
                                      at: .bottom,
                                      animated: true)
        }
    }
    
    private func updateTask()
    {
        // Update Existing Task
        self.taskManager.updateTask(updatedTask: self.txtFldAddTask.text!)
        self.tblTasks.reloadData()
        self.txtFldAddTask.text = nil
        self.btnAddTask.setTitle(BtnTaskType.addTask.rawValue,
                                 for: .normal)
    }
    
    private func logoutUser()
    {
        // Check Is Internet Conncted
        if (NetworkUtility.shared.isConnected) {
            
            AlertUtility.shared.showLogOutAlert(viewController: self) { (yesButtonAction) in
                
                self.view.isUserInteractionEnabled = false
                progressHUD.showSpinner()
                
                // SignOut and Navigate to LogInVC
                FirebaseManager.logout(view: self.view)
            }
        } else { // Show No Internet Connection Alert
            AlertUtility.shared.showNoInternetAlert(viewController: self)
        }
    }
}

extension TasksVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.taskManager.arrTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let tasksTableCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TasksTableCell.self)) as? TasksTableCell else {
            print("Tasks Table Cell Not Found")
            return UITableViewCell()
        }
        self.taskManager.arrTasks[indexPath.row].index = indexPath.row
        tasksTableCell.tasks = self.taskManager.arrTasks[indexPath.row]
        tasksTableCell.delegate = self
        return tasksTableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.txtFldAddTask.text = self.taskManager.arrTasks[indexPath.row].name
        self.taskManager.selectedTaskIndex = indexPath.row
        self.btnAddTask.setTitle(BtnTaskType.updateTask.rawValue,
                                 for: .normal)
    }
}

extension TasksVC: deleteTaskDelegate {
    
    func deleteTask(index: Int)
    {
        self.taskManager.arrTasks.remove(at: index)
        self.tblTasks.reloadData()
        if (self.taskManager.arrTasks.count >= 1) {
            self.tblTasks.scrollToRow(at: IndexPath(row: self.taskManager.arrTasks.count - 1, section: 0),
                                      at: .top,
                                      animated: true)
        }
    }
}

