//
//  Utils.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/17/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//
import UIKit

struct Utils {
    static func getUUID() -> String {
        return UUID().uuidString
    }
    
    static func display(votes: Int) -> String{
        let number = 1000
        var result = ""
        if votes < number {
            result = "\(votes)"
        } else {
            if votes % number == 0 {
                result = "\(votes/number)k"
            } else {
                let votesTotal = Double(votes)/Double(1000)
                result = String(format: "%.1fk", votesTotal)
            }
        }
        return result
    }
    
    static func format(date: Date) -> String {
        let min = 60
        let hour = min * 60
        let day = hour * 24
        let week = day * 27
        let year = day * 365
        let time = Int(Date().timeIntervalSince(date))
        if time < min {
            return "\(time)s"
        } else if time < hour {
            let min = time/min
            return "\(min)m"
        } else if time < day {
            let hour = time/hour
            return "\(hour)h"
        } else if time < week {
            let day = time/day
            return "\(day)d"
        } else if time < year {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dMMM"
            return dateFormater.string(from: date)
        }
        else {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dMMM y"
            return dateFormater.string(from: date)
        }
    }
}
