//
//  TaskView.swift
//  Doing
//
//  Created by rotem nevgauker on 1/30/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit

class TaskView: UIView {

    @IBOutlet weak var fiveWordsTitleLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
//    override init(frame:CGRect) {
//        
//        super.init(frame: frame)
//        comonInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        comonInit()
//    }
    
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "TaskView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    
    
    
   // private func comonInit(){}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
