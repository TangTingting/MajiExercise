//
//  ViewController.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
    
    var modle : GitHubModel?
    let titleLable = UILabel()
    let dataTextView = UITextView()
    var dataDic:NSDictionary?
    var dataText = ""
    
    var timer: Timer?
    
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
        contenView.backgroundColor = UIColor.white
        view.addSubview(contenView)
        
        dataTextView.font = Constants.Fonts.systemFontRegular(15)
        dataTextView.textColor = .black
        dataTextView.textAlignment = .left
        dataTextView.isEditable = false
        dataTextView.backgroundColor = UIColor.white
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
        
        getData()
    }
    
    
    
    @objc func getData() {
        MajiRequest.loadData(target: MajiApi.github, model: GitHubModel.self, success: { (model, data) in
            if let dict = try? JSONSerialization.jsonObject(with: data!,
                                                            options: .mutableContainers) as? [String : Any] {
                for (key, value) in dict {
                    self.dataText = self.dataText + key + " :\n"
                    self.dataText = self.dataText + (value as! String) + "\n\n";
                }
                self.dataTextView.text = self.dataText
            }
        }) { (code, message) in
            print("message=\(message)")
        }
    }
    func createTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 5.0,
                                         target: self,
                                         selector: #selector(getData),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    @objc func gotoHistory (){
        let historyVc = HistoryRecordViewController()
        navigationController?.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(historyVc, animated: true)
    }
}

