//
//  TableViewCell.swift
//  LabsChallenge
//
//  Created by Elizabeth Powell on 9/22/19.
//  Copyright © 2019 Elizabeth Powell. All rights reserved.
//

import UIKit

class DiningTableViewCell : UITableViewCell {
    
    var img_v: UIImageView!
    var status_lb: UILabel!
    var name_lb: UILabel!
    var hours_lb: UILabel!
    var UIcreator = Creator()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        img_v = UIcreator.createImageView()
        status_lb = UIcreator.createLabel(x: Int(img_v.frame.maxX + 14), y: 25, width: 200, height: 15, fontName: "Arial-BoldMT", fontSize: 14, textColor: UIColor.black)
        name_lb = UIcreator.createLabel(x: Int(status_lb.frame.minX), y: 41, width: Int(WIDTH - 28 - img_v.frame.width), height: 25, fontName: "Arial", fontSize: 20, textColor: UIColor.black)
        name_lb.adjustsFontSizeToFitWidth = true
        hours_lb = UIcreator.createLabel(x: Int(status_lb.frame.minX), y: 68, width: 200, height: 15, fontName: "Avenir-Light", fontSize: 14, textColor: UIColor.black)
        let arrow_lb = UIcreator.createLabel(x: Int(WIDTH - 20), y: Int(WIDTH * 0.32 / 3), width: 20, height: 20, fontName: "Ariel-BoldMT", fontSize: 60, textColor: UIColor.black)
        arrow_lb.text = "〉"
        
        addSubview(img_v)
        addSubview(status_lb)
        addSubview(name_lb)
        addSubview(hours_lb)
        addSubview(arrow_lb)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
