//
//  MainViewController.swift
//  CalendaeApp
//
//  Created by Artyom Beldeiko on 11.08.21.
//

import UIKit
import FSCalendar
import Firebase
import FirebaseDatabase



class MainViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var eventTableView: UITableView!
    
    
    
    let formatter = DateFormatter()
    let serverManager = ServerManager()
    
    
    var dateSelected: String = ""
    var targerDatesArray: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        calendar.delegate = self
        calendar.dataSource = self
        
        let eventCellXib = UINib(nibName: "EventTableViewCell", bundle: nil)
        eventTableView.register(eventCellXib, forCellReuseIdentifier: "EventTableViewCell")
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        
        let userId = Auth.auth().currentUser?.uid
        serverManager.downloadEventFromServer(for: userId!) { [weak self] events in
            guard let self = self else { return }
            DataStorage.shared.currentUser.events = events
            self.eventTableView.reloadData()
        } onError: { error in
            
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd.MM.yy"
        print("Date Selected = \(formatter.string(from: date))")
        dateSelected = formatter.string(from: date)
        eventTableView.reloadData()
    }
    
    
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        let dateString = formatter.string(from: date)
//        if DataStorage.shared.currentUser.events.filter({$0.date == dateString}).count >= 1 {
//
//            return 1
//        }
//
//        return 0
//
//    }
        
    @IBAction func createButtonClicked(_ sender: Any) {
        let createEventVC = storyboard?.instantiateViewController(identifier: "CreateEventViewController") as! CreateEventViewController
        navigationController?.pushViewController(createEventVC, animated: true)

    }
    
    @IBAction func calendarButtonClicked(_ sender: Any) {
        let calendarVC = storyboard?.instantiateViewController(identifier: "CalendarViewController") as! CalendarViewController
        navigationController?.present(calendarVC, animated: true, completion: nil)
        print("Calendar Button Clicked")
    }
    
    @IBAction func eventListButtonClicked(_ sender: Any) {
        let eventListVC = storyboard?.instantiateViewController(identifier: "EventListViewController") as! EventListViewController
        navigationController?.present(eventListVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.shared.currentUser.events.filter{$0.date == dateSelected}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as! EventTableViewCell
        
        targerDatesArray = DataStorage.shared.currentUser.events.filter{$0.date == dateSelected}
        
        let event = targerDatesArray[indexPath.row]
        
        cell.eventNameLabel.text = event.name
        cell.eventDescriptionLabel.text = event.desc
        cell.eventDateLabel.text = event.date
        cell.eventTimeLabel.text = event.time
        print(targerDatesArray.count)
        
        return cell
    }
    
    
    @objc func loadList() {
        
        self.eventTableView.reloadData()
        
    }
    
}
