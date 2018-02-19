//
//  MainTasksViewController.swift
//  Doing
//
//  Created by rotem nevgauker on 1/28/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit
import SpriteKit

class MainTasksViewController: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet var mainTasksViewModel:MainTasksViewModel!
    @IBOutlet weak var todayTomorrowView: SKView!
    @IBOutlet weak var futureView: SKView!
    @IBOutlet weak var overdueView: SKView!
    
    
    var todayTomorrowScene:TodayTomorrowScene?
    var futureScene:FutureScene?
    var overdueScene:OverdueScene?
    
    
    var firstDidApear = true
    
    
    //MARK: life cycle
    override func viewDidLoad() {
      
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.createBtn.layer.cornerRadius = self.createBtn.frame.size.width / 2
         self.createBtn.clipsToBounds = true
        scenesSetup()
        self.mainTasksViewModel.handleTasks(){
            
            DispatchQueue.main.async {
                let todayTomorrowTasks = Array(self.mainTasksViewModel.todayTomorrowTasks.values)
                self.todayTomorrowScene?.drawNodesFortasks(tasks:todayTomorrowTasks)
                let futureTasks = Array(self.mainTasksViewModel.futureTasks.values)
                self.futureScene?.drawNodesFortasks(tasks: futureTasks)
                let overdueTasks = Array(self.mainTasksViewModel.overdueTasks.values)
                self.overdueScene?.drawNodesFortasks(tasks: overdueTasks)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if firstDidApear {
            firstDidApear = false
            let height = view.frame.size.height
            let width = overdueView.frame.width + todayTomorrowView.frame.width + futureView.frame.width
            scrollView.contentSize = CGSize(width: width , height: height)
            scrollView.scrollRectToVisible(todayTomorrowView.frame, animated: false)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressCreateBtn(_ sender: Any) {
        performSegue(withIdentifier: "CreateTaskSegue", sender: self)
    }
    //MARK: setup
    func scenesSetup() {
        todayTomorrowScene = TodayTomorrowScene(size: todayTomorrowView.bounds.size)
        //todayTomorrowScene?.backgroundColor = UIColor.red
        todayTomorrowView.showsFPS = true
        todayTomorrowView.showsNodeCount = true
        todayTomorrowView.presentScene(todayTomorrowScene)
        todayTomorrowScene?.sceneSetup(vc:self)
        todayTomorrowScene?.isUserInteractionEnabled = true
        todayTomorrowScene?.scrollView = self.scrollView
        
        if let recog:UIPanGestureRecognizer = todayTomorrowScene?.panGestureRecognizer {
            recog.delegate = self

        }
        if let recog:UITapGestureRecognizer = todayTomorrowScene?.tapGestureRecognizer {
            recog.delegate = self
            
        }
        
        
        futureScene = FutureScene(size: futureView.bounds.size)
       // futureScene?.backgroundColor = UIColor.green
        futureView.showsFPS = true
        futureView.showsNodeCount = true
        futureView.presentScene(futureScene)
        futureScene?.sceneSetup(vc:self)
        futureScene?.isUserInteractionEnabled = true
        futureScene?.scrollView = self.scrollView
        
        if let recog:UIPanGestureRecognizer = futureScene?.panGestureRecognizer {
            recog.delegate = self
            
        }
        if let recog:UITapGestureRecognizer = futureScene?.tapGestureRecognizer {
            recog.delegate = self
            
        }

        
        overdueScene = OverdueScene(size: overdueView.bounds.size)
       // overdueScene?.backgroundColor = UIColor.blue
        overdueView.showsFPS = true
        overdueView.showsNodeCount = true
        overdueView.presentScene(overdueScene)
        overdueScene?.sceneSetup(vc:self)
        overdueScene?.isUserInteractionEnabled = true
        overdueScene?.scrollView = self.scrollView
        
        if let recog:UIPanGestureRecognizer = overdueScene?.panGestureRecognizer {
            recog.delegate = self
            
        }
        if let recog:UITapGestureRecognizer = overdueScene?.tapGestureRecognizer {
            recog.delegate = self
            
        }



    }
    
    
    
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("scrolling")
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "EditTaskSegue" {
            
            let vc = segue.destination as! CreateTaskViewController
            vc.createViewControllerState = CreateViewControllerState.update
            var node:TaskNode?
            if self.overdueScene?.selectedNode != nil && (self.overdueScene?.selectedNode.wasTapped)! {
                node = self.overdueScene?.selectedNode
            }else if self.futureScene?.selectedNode != nil && (self.futureScene?.selectedNode.wasTapped)!{
                node = self.futureScene?.selectedNode
            }else {
                node = self.todayTomorrowScene?.selectedNode
            }
            
            if let selected:TaskNode = node {
                
                if let id = selected.taskId {
                
                    if (mainTasksViewModel.overdueTasks[id] != nil) {
                        if let task = mainTasksViewModel.overdueTasks[id] {
                            vc.createViewModel.updateModel(task: task)
                        }
                        
                    }else if (mainTasksViewModel.todayTomorrowTasks[id] != nil){
                        if let task = mainTasksViewModel.todayTomorrowTasks[id] {
                            vc.createViewModel.updateModel(task: task)
                        }
                    }else {
                        if let task = mainTasksViewModel.futureTasks[id] {
                            vc.createViewModel.updateModel(task: task)
                        }
                    }
                }
            }
        }
        
    }
    
    //Mark:UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            return true
            
    }
}
