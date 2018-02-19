//
//  LoginViewModel.swift
//  Doing
//
//  Created by rotem nevgauker on 1/28/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    var email:String = ""
    var password:String = ""
    
    func login(withEmail:String, password:String, completion: @escaping () -> ()) {
        Networking.shared.login(withEmail: withEmail, password: password){
            completion()
            
        }
        
    }

    

}
