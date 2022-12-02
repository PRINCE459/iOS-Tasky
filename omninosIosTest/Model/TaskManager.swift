//
//  TaskManager.swift
//  omninosIosTest
//
//  Created by Prince 2.O on 02/12/22.
//

import Foundation

class TaskManager {

    var arrTasks: [TaskModel] = []
    var selectedTaskIndex: Int?
    
    func addTask(taskName: TaskModel)
    {
        self.arrTasks.append(taskName)
    }
    
    func updateTask(updatedTask: String)
    {
        if let taskIndex = selectedTaskIndex {
            self.arrTasks[taskIndex].name = updatedTask
        }
    }
    
}
