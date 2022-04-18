//
//  ServerManager.swift
//  CalendaeApp
//
//  Created by Artyom Beldeiko on 19.08.21.
//

import Foundation
import FirebaseDatabase
import Firebase

class ServerManager {
    
    func sendEventToServer (_ event: Event) {
        let eventJson = ["id": event.id,
                    "name": event.name,
                    "desc": event.desc,
                    "date": event.date,
                    "time": event.time,
                    "userId": event.userId]
        let database = Database.database().reference()
        let child = database.child("event").child("\(event.id)")
        child.setValue(eventJson) {  error, ref in
            
        }
    }
    
    func downloadEventFromServer (for userId: String, onComplete: @escaping ([Event]) -> Void, onError: @escaping (String) -> Void) {
        let database = Database.database().reference()
        let child = database.child("event").queryOrdered(byChild: "userId").queryEqual(toValue: userId)
        child.observeSingleEvent(of: .value) { response in
            if let value = response.value as? [String: Any] {
                var result: [Event] = []
                for item in value.values {
                    if let eventJson = item as? [String: Any] {
                        if let id = eventJson["id"] as? String, let userId = eventJson["userId"] as? String, let name = eventJson["name"] as? String, let desc = eventJson["desc"] as? String, let date = eventJson["date"] as? String, let time = eventJson["time"] as? String {
                            
                            let event = Event()
                            event.id = id
                            event.userId = userId
                            event.name = name
                            event.desc = desc
                            event.date = date
                            event.time = time
                            
                            result.append(event)
                        }
                    }
                
                }
                
                    onComplete(result)
                
                    } else  {
            
                        onError("Event load erorr occur")
                    }
        }
    
    }

}
