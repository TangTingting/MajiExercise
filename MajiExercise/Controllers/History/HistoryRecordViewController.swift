//
//  HistoryRecordViewController.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import UIKit

class HistoryRecordViewController: BaseTableViewController {
    
    let refreshCtrl = UIRefreshControl()
    var historyArray : [History]=[]
    let newMsgView = UIView()
    let label = UILabel()
    var newDataComing = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(newDataComing(notification:)), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.History.HistoryTitle
        let rightItem = UIBarButtonItem(title: Strings.History.ClearData, style: .plain, target: self, action: #selector(clearAllData))
        navigationItem.rightBarButtonItem = rightItem
        
        tableView.rowHeight = 60
        refreshCtrl.attributedTitle = NSAttributedString(string: Strings.PullToRefresh)
        refreshCtrl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.addSubview(refreshCtrl)
        
        label.text = Strings.History.NewDataAlert
        label.font = Constants.Fonts.systemFontBold(16)
        label.textColor = .darkGray
        label.textAlignment = .center
        
        newMsgView.addSubview(label)
        newMsgView.backgroundColor = .lightGray
        
        label.snp.makeConstraints { (make) -> Void in
            make.size.height.equalTo(50)
            make.size.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        getHistoryData()
    }
    
    func getHistoryData(){
        historyArray = CoreDataManager.shared.getAllHistory()
        tableView.reloadData()
    }
    
    @objc func refreshAction() {
        newDataComing = false
        getHistoryData()
        refreshCtrl.endRefreshing()
    }
    
    @objc func clearAllData(){
        CoreDataManager.shared.deleteAllHistory()
        getHistoryData()
    }
    
    @objc func newDataComing(notification: Notification) {
        newDataComing = true
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let history:History = historyArray[indexPath.row]
        var isLast = false
        if indexPath.row == 0 {
            isLast = true
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: "HistoryListCell") as? HistoryListCell
        if cell == nil {
            cell = HistoryListCell()
        }
        cell?.reloadCell(data: history,isLast: isLast)
        cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle = .none
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history:History = historyArray[indexPath.row]
        gotoDetail(data: history)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return newDataComing ? 50 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return newDataComing ? self.newMsgView : nil
    }
    
    func gotoDetail(data:History){
        let detailVc = MainViewController()
        detailVc.isMain = false
        detailVc.title = Strings.History.DataDetail
        detailVc.data = data
        navigationController?.pushViewController(detailVc, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
