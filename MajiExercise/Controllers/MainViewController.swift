//
//  ViewController.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.Main.MainTitle
        getData()
    }
    
    func getData() {
        MajiRequest.loadData(target: MajiApi.github, model: GitHubModel.self, success: { (model, data) in
            print("model=\(model!)")
            print("data=\(data!)")
            
        }) { (code, message) in
            print("message=\(message)")
        }
    }
}

