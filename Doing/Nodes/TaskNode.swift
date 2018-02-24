//
//  TaskNode.swift
//  Doing
//
//  Created by rotem nevgauker on 2/12/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit
import SpriteKit

class TaskNode: SKShapeNode {
    
    var taskId:String?
    var wasTapped = false
    func setPhysicsBody() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: 45.0)
        self.physicsBody?.restitution = 0.4
        self.physicsBody?.allowsRotation = false
    }
    func setGUI(task:Task){
        if let colorStr = task.color {
            if let color = UIColor(hexString: colorStr) {
                self.fillColor = color
            }
        }
        let label = SKLabelNode(text: task.fiveWordsTitle)
        label.fontColor = UIColor.white
        label.fontSize = 14
        self.addChild(label)
    }
}
