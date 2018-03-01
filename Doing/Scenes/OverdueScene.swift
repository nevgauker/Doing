//
//  OverdueScene.swift
//  Doing
//
//  Created by rotem nevgauker on 2/14/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit

class OverdueScene: TasksScene {
    override func sceneSetup(vc:UIViewController) {
        name = "Overdue"
        super.sceneSetup(vc: vc)
    }
    
    override func triggerCompletionDateChange() {
        let position = selectedNode.frame.origin
        let x = position.x
        if (x + selectedNode.frame.size.width) >= (self.frame.size.width - 0.4) {
            //enable
            enableCompletionDate(on: true)
            completionDateStr = CompletionDate.today.rawValue

            
        }else {
            //disable
            enableCompletionDate(on: false)
            completionDateStr = ""

        }
    }
   
    
}
