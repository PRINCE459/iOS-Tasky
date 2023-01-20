//
//  TasksTableCell.swift
//  Tasky
//
//  Created by Its_official_Haryanvi on 29/11/22.
//

import UIKit

protocol deleteTaskDelegate {
    func deleteTask(index: Int)
}

class TasksTableCell: UITableViewCell {

    @IBOutlet weak var lblTaskName: UILabel!
    var delegate: deleteTaskDelegate?
    var tasks: TaskModel? {
        willSet {
            self.setupCell(model: newValue ?? TaskModel())
        }
    }
    
    @IBAction func deleteTaskBtnPressed(_ sender: UIButton)
    {
        if let taskIndex = tasks?.index {
            self.delegate?.deleteTask(index: taskIndex)
        }
    }
}

extension TasksTableCell {
    
    private func setupCell(model: TaskModel)
    {
        self.lblTaskName.text = model.name
    }
}
