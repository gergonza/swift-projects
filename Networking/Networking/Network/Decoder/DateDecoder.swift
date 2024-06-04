//
//  DateDecoder.swift
//  Networking
//  Personal Decoder to Dates Field
//
//  Created by Germán González on 11/6/23.
//

import Foundation

final class DateDecoder:JSONDecoder {
    
    let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        
        // "2020-10-10T03:50:06.151+05:30"
        dateFormatter.dateFormat = "yyyy-MM-dd-'T'HH:mm:ss.SSSXXX"
        
        // Assign the formatter
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
