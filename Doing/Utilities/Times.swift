//
//  Times.swift
//  Doing
//
//  Created by rotem nevgauker on 2/13/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import  Foundation

class Times {
    
    class func todayDateString()->String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let result = formatter.string(from: date)
        return result
    }
    
    class func dateString(dateStr:String)->String? {
    
        var date:Date?
        if dateStr == CompletionDate.today.rawValue {
            date = Date()
        }
        else if dateStr == CompletionDate.tomorrow.rawValue {
            date = Date().tomorrow
        }
        var result:String?
        if let value = date {
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat
             result = formatter.string(from: value)
        }
        return result
        
    }

}
