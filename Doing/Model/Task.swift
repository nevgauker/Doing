//
//  Task.swift
//  Doing
//
//  Created by rotem nevgauker on 1/28/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit

class Task: NSObject {
    var id:String?
    var fiveWordsTitle:String?
    var text:String?
    var completionDate:String?
    var completionDateString:String
    var creationDate:String?
    var color:String?
    
    init(id:String,fiveWordsTitle:String, text:String,completionDate:String,completionDateString:String,creationDate:String, color:String) {
        self.fiveWordsTitle = fiveWordsTitle
        self.text = text
        self.id = id
        self.completionDateString = completionDateString
        self.color = color
        if self.completionDate != "" {
            self.completionDate = completionDate
        }
        
        if creationDate == "" {
            self.creationDate = Times.todayDateString()
        }else {
              self.creationDate = creationDate
        }
    }
    
    func isOverdue()-> Bool {
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let completionDate = formatter.date(from: self.completionDate!)
        let str = formatter.string(from: Date())
        let today = formatter.date(from:str)
        if completionDate?.compare(today!) == .orderedAscending  {
            return true
        }
        return false
    }
}
