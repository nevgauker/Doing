//
//  LoginViewController.swift
//  Doing
//
//  Created by rotem nevgauker on 1/28/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit
import FirebaseAuth

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            
            passwordTextField.becomeFirstResponder()
        }
        return true
    }
    
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet var loginViewModel:LoginViewModel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: actions
    @IBAction func didPressLoginBtn(_ sender: Any) {
        
        loginViewModel.login(withEmail: loginViewModel.email, password: loginViewModel.password){
            
            if Auth.auth().currentUser != nil {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "MainTasksView")
                    self.present(controller, animated: true, completion: nil)
                }
            }else {
                //display error
            }
        }
    }
    
    
    @IBAction func didChangeEmail(_ sender: UITextField) {
        loginViewModel.email = sender.text!
    }
    
    @IBAction func didChangePassword(_ sender: UITextField) {
        loginViewModel.password = sender.text!
    }
    
   

}
