//
//  ViewController.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

class MainViewController: BaseViewController {
    
    var modle : GitHubModel?
    let titleLable = UILabel()
    let dataTextView = UITextView()
    var dataDic:NSDictionary?
    var dataText = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(notification:)), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.Main.MainTitle
        let rightItem = UIBarButtonItem(image: UIImage(named: "history_ico"), style:.plain , target:self, action: #selector(gotoHistory))
        navigationItem.rightBarButtonItem = rightItem
        
        titleLable.font = Constants.Fonts.systemFontBold(16)
        titleLable.textColor = .black
        titleLable.textAlignment = .left
        titleLable.text = Strings.Main.DataRequest
        view.addSubview(titleLable)
        
        let contenView = UIView()
        contenView.backgroundColor = .white
        view.addSubview(contenView)
        
        dataTextView.font = Constants.Fonts.systemFontRegular(15)
        dataTextView.textColor = .black
        dataTextView.textAlignment = .left
        dataTextView.isEditable = false
        dataTextView.backgroundColor = .white
        contenView.addSubview(dataTextView)
        
        
        titleLable.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp_topMargin).offset(20)
            make.left.equalTo(24)
        }
        contenView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLable.snp_bottomMargin).offset(20)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        dataTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLable.snp_bottomMargin).offset(20)
            make.left.equalTo(24)
            make.right.equalTo(24)
            make.bottom.equalTo(view.snp_bottomMargin).offset(-10)
        }
        
        getLastData()
    }
    
    @objc func getLastData() {
        let fetchRequest: NSFetchRequest = History.fetchRequest()
        fetchRequest.fetchLimit = 1
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            if result.count >= 1 {
                let lastData = result.first! as History
                dataTextView.text = lastData.dataText
            }
        } catch {
            fatalError();
        }
    }
    
    @objc func updateData(notification: Notification) {
        let data = notification.userInfo!["newData"] as! History
        dataTextView.text = data.dataText
    }
    
    @objc func gotoHistory (){
        let historyVc = HistoryRecordViewController()
        navigationController?.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(historyVc, animated: true)
    }
}

