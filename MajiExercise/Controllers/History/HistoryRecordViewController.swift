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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.History.HistoryTitle
        let rightItem = UIBarButtonItem(title: Strings.History.ClearData, style: .plain, target: self, action: #selector(clearAllData))
        navigationItem.rightBarButtonItem = rightItem
        
        tableView.rowHeight = 60
        refreshCtrl.attributedTitle = NSAttributedString(string: Strings.PullToRefresh)
        refreshCtrl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.addSubview(refreshCtrl)
        getHistoryData()
    }

    func getHistoryData(){
       
    }
    
    @objc func clearAllData(){
        
    }
    
    @objc func refreshAction() {
        refreshCtrl.endRefreshing()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "HistoryListCell") as? HistoryListCell
           if cell == nil {
             cell = HistoryListCell()
           }
        cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle = .none
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoDetail()
    }
    
    
    func gotoDetail(){
        let detailVc = RecordDetailController()
        navigationController?.pushViewController(detailVc, animated: true)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
