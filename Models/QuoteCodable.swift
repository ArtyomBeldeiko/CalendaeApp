//
//  QuoteCodable.swift
//  CalendaeApp
//
//  Created by Artyom Beldeiko on 9.07.21.
//

import Foundation


// MARK: - User
struct Quote: Codable {
    let quoteText, quoteAuthor, senderName, senderLink: String?
    let quoteLink: String?
}
