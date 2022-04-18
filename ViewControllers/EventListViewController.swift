//
//  EventListViewController.swift
//  CalendaeApp
//
//  Created by Artyom Beldeiko on 29.08.21.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var eventListTableView: UITableView!
    @IBOutlet weak var eventLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
        
        let eventCellXib = UINib(nibName: "EventTableViewCell", bundle: nil)
        eventListTableView.register(eventCellXib, forCellReuseIdentifier: "EventTableViewCell")
        
        
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.shared.currentUser.events.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let event = DataStorage.shared.currentUser.events.sorted(by: {$0.date > $1.date})[indexPath.row]
            
            let cell = eventListTableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as! EventTableViewCell
            
            cell.eventNameLabel.text = event.name
            cell.eventDescriptionLabel.text = event.desc
            cell.eventDateLabel.text = event.date
            cell.eventTimeLabel.text = event.time
            
            return cell
        }
        


}
