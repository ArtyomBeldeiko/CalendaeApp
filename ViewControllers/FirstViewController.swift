//
//  ViewController.swift
//  CalendaeApp
//
//  Created by Artyom Beldeiko on 7.06.21.
//

import UIKit
import Firebase

class FirstViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var stackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var eyeButtonLabel: UIButton!
    
    
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
    
    @IBAction func createAccountButtonClicked(_ sender: Any) {
        let secondVC = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        navigationController?.pushViewController(secondVC, animated: true)
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

    @IBAction func signInButtonClicked(_ sender: Any) {
        if let email = emailField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                if user != nil {
                    let quoteVC = self.storyboard?.instantiateViewController(identifier: "QuoteViewController") as! QuoteViewController
                    self.navigationController?.pushViewController(quoteVC, animated: true)
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
    
    @IBAction func secureTextEntry(_ sender: Any) {
        eyeButtonLabel.isSelected.toggle()
        passwordTextField.isSecureTextEntry.toggle()
    }
}

