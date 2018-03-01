//
//  TodayTomorrowScene.swift
//  Doing
//
//  Created by rotem nevgauker on 2/1/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//
import  UIKit

class TodayTomorrowScene: TasksScene {

    override func sceneSetup(vc:UIViewController) {
        name = "Today and tomorrow"
        super.sceneSetup(vc: vc)
    }
    
    
    override func triggerCompletionDateChange() {
        let position = selectedNode.frame.origin
        let x = position.x
        if (x + selectedNode.frame.size.width) >= (self.frame.size.width - 0.4) {
            enableCompletionDate(on: true)
            completionDateStr = CompletionDate.inTheFuture.rawValue

            
        }else {
            //disable
            enableCompletionDate(on: false)
            completionDateStr = ""

        }
    }
}
