//
//  SecondViewController.swift
//  CalendaeApp
//
//  Created by Artyom Beldeiko on 8.06.21.
//

import UIKit
import Firebase

class SecondViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var stackTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboarddDidHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc func keyboardDidShow (_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
    }
    
    @objc func keyboarddDidHide (_ notification: Notification) {
        if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
            if let email = emailTextField.text, let password = PasswordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { user, error in
                    if user != nil {
                        let firstVC = FirstViewController()
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        let errorMessage = error?.localizedDescription ?? "Error"
                        let alertVC = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
            }
        }
    
}
