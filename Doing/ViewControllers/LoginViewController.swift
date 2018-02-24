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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == passwordTextField {
            
            
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }else {
            didPressLoginBtn(loginBtn)
        }
        return true
    }
    
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet var loginViewModel:LoginViewModel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginBtn: UIButton!

    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setGUI()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: setup
    func setGUI(){
        loginBtn.layer.cornerRadius = 10.0
        loginBtn.layer.shadowColor = UIColor.black.cgColor
        loginBtn.layer.shadowOpacity = 0.4
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
    
    
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.view.frame.size.height + keyboardHeight)
        }
    }
    
   

}
