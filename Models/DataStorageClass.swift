//
//  DataStorageClass.swift
//  CalendaeApp
//
//  Created by Artyom Beldeiko on 24.08.21.
//

import Foundation

class DataStorage {
    static let shared = DataStorage()
    var currentUser = User()
    var userEvent = Event()
    
    private init() {
        
    }
}
