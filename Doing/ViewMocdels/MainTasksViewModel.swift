//
//  MainTasksViewModel.swift
//  Doing
//
//  Created by rotem nevgauker on 1/29/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MainTasksViewModel: NSObject {
    
    var todayTomorrowTasks:[String : Task] = [String : Task]()
    var futureTasks:[String : Task] = [String : Task]()
    var overdueTasks:[String : Task] = [String : Task]()

    var refTasks: DatabaseReference =  Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("tasks")
    func removeAll() {
        self.todayTomorrowTasks.removeAll()
        self.futureTasks.removeAll()
        self.overdueTasks.removeAll()
    }
    
    func handleTasks(completion: @escaping () -> ()) {
        
        refTasks.observe(DataEventType.value, with: { (snapshot) in
        
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
               self.removeAll()
                
                for tasks in snapshot.children.allObjects as! [DataSnapshot] {
                    let taskObject = tasks.value as? [String: AnyObject]
                    let id  = taskObject?["id"] as? String ?? ""
                    let fiveWordsTitle  = taskObject?["fiveWordsTitle"] as? String ?? ""
                    let text = taskObject?["text"] as? String ?? ""
                    let completionDateString = taskObject?["completionDateString"] as? String ?? ""
                    let creationDate = taskObject?["creationDate"] as? String ?? ""
                    let completionDate = taskObject?["completionDate"] as? String ?? ""
                    let color = taskObject?["color"] as? String ?? ""
                    let task = Task(id: id, fiveWordsTitle: fiveWordsTitle, text: text, completionDate: completionDate, completionDateString: completionDateString, creationDate:creationDate, color:color)
                    if task.isOverdue() {
                        self.overdueTasks[id] = task
                    }else if task.completionDateString == CompletionDate.inTheFuture.rawValue {
                        self.futureTasks[id] = task
                    }else {
                        self.todayTomorrowTasks[id] = task
                    }
                    completion()
                }
            }
        })
    }
}


