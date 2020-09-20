//
//  HistoryListCell.swift
//  MajiExercise
//
//  Created by Ting on 2020/9/20.
//  Copyright © 2020 Ting. All rights reserved.
//

import UIKit

class HistoryListCell: UITableViewCell {
    
    let timeLabel = UILabel()
    let line = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initContainerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func initContainerView() {
        timeLabel.font = Constants.Fonts.systemFontRegular(14)
        timeLabel.textAlignment = .left
        timeLabel.textColor = UIColor.black
        timeLabel.text = "2020.05.08 23:22:22"
        addSubview(timeLabel)
        
        line.backgroundColor = Constants.Colors.GrayLineColor
        addSubview(line)
        
        timeLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView)
            make.centerY.equalTo(contentView)
            make.left.equalTo(24)
        }
        line.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.bottom.equalTo(contentView)
            make.height.equalTo(0.5)
        }
    }
    
//    func reloadCell(_ record:History) {
//        
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
