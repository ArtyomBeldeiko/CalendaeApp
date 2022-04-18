//
//  CreateEventViewController.swift
//  CalendaeApp
//
//  Created by Artyom Beldeiko on 8.08.21.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateEventViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventDateTextField: UITextField!
    @IBOutlet weak var eventTimeTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    
    let dateDatePicker = UIDatePicker()
    let timeDatePicker = UIDatePicker()
    let event = Event()
    let serverManager = ServerManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventDescriptionTextView.delegate = self
        
        eventDateTextField.inputView = dateDatePicker
        dateDatePicker.datePickerMode = .date
        dateDatePicker.preferredDatePickerStyle = .wheels
        
        eventTimeTextField.inputView = timeDatePicker
        timeDatePicker.datePickerMode = .time
        timeDatePicker.preferredDatePickerStyle = .wheels
        timeDatePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        
        let currentDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        dateDatePicker.minimumDate = currentDate
        
        
        dateDatePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        timeDatePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        let tapGestureDate = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        self.view.addGestureRecognizer(tapGestureDate)
        
        let tapGestureTime = UITapGestureRecognizer(target: self, action: #selector(tapGestureTimeDone))
        self.view.addGestureRecognizer(tapGestureTime)
        
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        eventDescriptionTextView.text = ""
    }
    
    func getDateFromDateDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        eventDateTextField.text = formatter.string(from: dateDatePicker.date)
    }
    
    func getTimeFromTimeDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        eventTimeTextField.text = formatter.string(from: timeDatePicker.date)
    }
    
    @objc func timeChanged() {
        getTimeFromTimeDatePicker()
    }
    
    @objc func dateChanged() {
           getDateFromDateDatePicker()
       }

    @objc func tapGestureDone() {
        view.endEditing(true)
    }
    
    @objc func tapGestureTimeDone() {
        view.endEditing(true)
    }
    
    @IBAction func createButtonClicked(_ sender: Any) {
        
        let id = UUID().uuidString
        let userId = Auth.auth().currentUser?.uid
        
        event.name = eventNameTextField.text ?? ""
        event.date = eventDateTextField.text ?? ""
        event.time = eventTimeTextField.text ?? ""
        event.desc = eventDescriptionTextView.text
        event.id = id
        event.userId = userId!
        
        DataStorage.shared.currentUser.events.append(event)
        
        serverManager.sendEventToServer(event)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        navigationController?.popViewController(animated: true)
        
    }
    

}


