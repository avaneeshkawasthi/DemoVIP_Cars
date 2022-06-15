//
//  DateTimeFormatter.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation



extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/India")
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}

extension Date {

    func toString(withFormat format: String = "EEEE ، d MMMM yyyy") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/India")
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}
