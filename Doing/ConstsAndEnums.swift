//
//  ConstsAndEnums.swift
//  Doing
//
//  Created by rotem nevgauker on 1/30/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit


public enum CompletionDate:String {
    case today = "Today"
    case tomorrow = "Tomorrow"
    case inTheFuture = "In The Future"
    static var count: Int { return CompletionDate.inTheFuture.hashValue + 1}
    
    static var all = ["Today","Tomorrow","In The Future"]
    
}


public enum CreateViewControllerState:Int {
    case create = 0
    case update = 1
  
}

public let dateFormat:String = "dd.MM.yyyy"

public let tasksColors:[UIColor] = [UIColor.flatRed,UIColor.flatMint,UIColor.flatBlue,
                        UIColor.flatLime,UIColor.flatTeal,UIColor.flatGray,
                        UIColor.flatPink,UIColor.flatPlum,UIColor.flatSand]



class ConstsAndEnums: NSObject {
    

}
