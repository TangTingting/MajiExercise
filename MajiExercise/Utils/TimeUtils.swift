//
//  TimeUtils.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import UIKit

class TimeUtils: NSObject {
      static func timeIntervalChangeToTimeStr(timeInterval:Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
           let date:NSDate = NSDate.init(timeIntervalSince1970: timeInterval)
           let formatter = DateFormatter.init()
           if dateFormat == nil {
               formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           }else{
               formatter.dateFormat = dateFormat
           }
           return formatter.string(from: date as Date)
       }
}
