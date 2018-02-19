//
//  Networking.swift
//  Doing
//
//  Created by rotem nevgauker on 1/28/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol login {
    func didLogin(error:Error)
}


class Networking: NSObject {
    
    static let shared = Networking()

    func login (withEmail: String, password: String, completion: @escaping () -> ()) {
        
        Auth.auth().signIn(withEmail: withEmail, password: password) { (user, error) in
            if error != nil {
                
                Auth.auth().createUser(withEmail: withEmail, password: password) { (user, error) in
                    if error != nil {
                        //invalid username or password
                         completion()
                    }else {
                        
                        // return user
                         completion()
                    }
                }
            }else {
                //return user
                completion()
            }
        }
        
    }

  func logout (completion: @escaping () -> ()) {
    
        do {
             try Auth.auth().signOut()
        }catch {
            print ("logout fail")
        }
        completion()
    }

    
    

}
