//
//  TasksScene.swift
//  Doing
//
//  Created by rotem nevgauker on 2/14/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit
import SpriteKit



private let kAnimalNodeName = "movable"



class TasksScene: SKScene {
    
    var selectedNode:TaskNode = TaskNode()
    var tasksNodes:[SKShapeNode] = [SKShapeNode]()
    var containerViewController:UIViewController?
    var panGestureRecognizer:UIPanGestureRecognizer?
    var tapGestureRecognizer:UITapGestureRecognizer?
    
    var scrollView:UIScrollView?
    
    override init(size: CGSize) {
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sceneSetup(vc:UIViewController) {
        self.physicsBody = SKPhysicsBody (edgeLoopFrom: self.frame)
        self.containerViewController = vc
        
    }
    
    func  drawNodesFortasks(tasks:[Task]){
        
        if tasksNodes.count > 0 {
            self.removeChildren(in: tasksNodes)
            self.tasksNodes.removeAll()
        }
        
        for task in tasks {
            
            let taskNode = TaskNode(circleOfRadius: 45.0)
            taskNode.setPhysicsBody()
            taskNode.taskId = task.id
            let value_x = self.frame.size.width / 2 - taskNode.frame.size.width / 2
            let value_y = self.frame.size.height / 2 - taskNode.frame.size.height / 2
            taskNode.position = CGPoint(x: value_x, y: value_y)
            taskNode.name = kAnimalNodeName
            taskNode.setGUI(task: task)
            self.tasksNodes.append(taskNode)
            self.addChild(taskNode)
        }
    }
    
    override func didMove(to view: SKView) {
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanFrom(recognizer:)))
        panGestureRecognizer?.cancelsTouchesInView = false
        
         tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFrom(recognizer:)))
        tapGestureRecognizer?.cancelsTouchesInView = false

        self.view!.addGestureRecognizer(panGestureRecognizer!)
        self.view!.addGestureRecognizer(tapGestureRecognizer!)
        
    }
    func handleTapFrom(recognizer : UIPanGestureRecognizer) {
        
        var touchLocation = recognizer.location(in: recognizer.view)
        touchLocation = self.convertPoint(fromView: touchLocation)
        self.selectNodeForTouch(touchLocation: touchLocation)
        
        if let viewController = containerViewController {
            if let _ = selectedNode.taskId {
                selectedNode.wasTapped = true 
                viewController.performSegue(withIdentifier: "EditTaskSegue", sender: self)
                //selectedNode = TaskNode()
            }
        }
    }
    func handlePanFrom(recognizer : UIPanGestureRecognizer) {
        
        if recognizer.state == .began {
            var touchLocation = recognizer.location(in: recognizer.view)
            touchLocation = self.convertPoint(fromView: touchLocation)
            
            self.selectNodeForTouch(touchLocation: touchLocation)
        } else if recognizer.state == .changed {
            if selectedNode.name == kAnimalNodeName {
                self.scrollView?.isScrollEnabled = false
                selectedNode.physicsBody?.isDynamic = false
                var translation = recognizer.translation(in: recognizer.view!)
                translation = CGPoint(x: translation.x, y: -translation.y)
                self.panForTranslation(translation: translation)
            }
            
            
            recognizer.setTranslation(.zero, in: recognizer.view)
        } else if recognizer.state == .ended {
            selectedNode.physicsBody?.isDynamic = true
            selectedNode = TaskNode()
            self.scrollView?.isScrollEnabled = true
        }
    }
    
    func degToRad(degree: Double) -> CGFloat {
        return CGFloat(degree / 180.0 * M_PI)
    }
    
    func selectNodeForTouch(touchLocation : CGPoint) {
        
        let touchedNode = self.atPoint(touchLocation)
        if touchedNode is SKShapeNode {
            if !(selectedNode.isEqual(touchedNode)) {
                selectedNode.removeAllActions()
                selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                selectedNode = (touchedNode as? TaskNode)!
            }
        }else if touchedNode is SKLabelNode {
            
            let parent =  touchedNode.parent
            if !(selectedNode.isEqual(parent)) {
                selectedNode.removeAllActions()
                selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                selectedNode = (parent as? TaskNode)!
            }
        }
        selectedNode.physicsBody?.isDynamic = false
    }
    
    func panForTranslation(translation : CGPoint) {
        let position = selectedNode.position
        if selectedNode.name == kAnimalNodeName {
            selectedNode.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
        }
    }
}

