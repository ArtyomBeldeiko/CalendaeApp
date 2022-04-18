//
//  CalendarViewController.swift
//  CalendaeApp
//
//  Created by Artyom Beldeiko on 28.08.21.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    let formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("backButtonCliked")
    }
    
    
    
    
    

}
