//
//  MajiFunctions.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import UIKit
import CoreData

class MajiFunctions: NSObject {
    
    static var timer:Timer?
    
    static func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 5.0,
                                         target: self,
                                         selector: #selector(getGitHubData),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    @objc static func getGitHubData(){
        var dataText = ""
        MajiRequest.loadData(target: MajiApi.github, model: GitHubModel.self, success: { (model, data) in
            if let dict = try? JSONSerialization.jsonObject(with: data!,
                                                            options: .mutableContainers) as? [String : Any] {
                for (key, value) in dict {
                    dataText = dataText + key + " :\n"
                    dataText = dataText + (value as! String) + "\n\n";
                }
            }
            let dateNow:Date = Date.init(timeIntervalSinceNow: 0)
            let time:TimeInterval = dateNow.timeIntervalSince1970;
            let timeLine = Int64(time)
            let history = NSEntityDescription.insertNewObject(forEntityName: "History", into: CoreDataManager.shared.context) as! History
            history.timeLine = timeLine
            history.dataText = dataText
            history.isNew = true
            CoreDataManager.shared.saveHistoryDataWith(history: history)
            
        }) { (code, message) in
            print("message=\(message)")
        }
    }
    
    static func clearTimer(){
        MajiFunctions.timer!.invalidate()
        MajiFunctions.timer = nil
    }
}

