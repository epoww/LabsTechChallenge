//
//  UICreator.swift
//  LabsChallenge
//
//  Created by Elizabeth Powell on 9/23/19.
//  Copyright © 2019 Elizabeth Powell. All rights reserved.
//

import Foundation
import UIKit
import WebKit

public class Creator {
    
    // Creates main table view, could be made more generic in future if more table views are needed
    func tbvCreator() -> UITableView {
        let tbv = UITableView()
        tbv.frame = CGRect(x: 0, y: 75, width: WIDTH, height: HEIGHT - 75)
        tbv.separatorStyle = .none
        tbv.register(DiningTableViewCell.self, forCellReuseIdentifier: "dining cell")
        return tbv
    }
    
    // Creates a lable given parameters
    func createLabel(x: Int, y: Int, width: Int, height: Int, fontName: String, fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let date_lb = UILabel()
        date_lb.frame = CGRect(x: x, y: y, width: width, height: height)
        date_lb.font = UIFont(name: fontName, size: fontSize)
        date_lb.textColor = textColor
        return date_lb
    }
    
    // Creates web view, could be made more generic in future if more web views are needed
    func webVCreator() -> WKWebView {
        let webv = WKWebView()
        webv.frame = CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT)
        return webv
    }
    
    // Creates activity indicator
    func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        return activityIndicator
    }
    
    // Creates close web view button, could be made more generic in future if more buttons are needed
    func createCloseWebViewButton() -> UIButton {
        let close_btn = UIButton()
        close_btn.frame = CGRect(x: 15, y: 35, width: 35, height: 35)
        close_btn.setTitle("x", for: .normal)
        close_btn.setTitleColor(UIColor.white, for: .normal)
        close_btn.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
        close_btn.backgroundColor = UIColor.lightGray
        close_btn.alpha = 0.6
        return close_btn
    }
    
    // Creates header view within table view,  could be more generic in future if more UI views are needed
    func createHeaderView(section: Int) -> UIView {
        let header_v = UIView()
        header_v.frame = CGRect(x: 0, y: 0, width: WIDTH, height: 54)
        header_v.backgroundColor = UIColor.white
        
        let title_lb = UILabel()
        title_lb.frame = CGRect(x: 14, y: 7, width: 200, height: 40)
        title_lb.font = UIFont(name: "Arial-BoldMT", size: 30)
        
        header_v.addSubview(title_lb)
        
        if section == 0 { title_lb.text = "Dining Halls" }
        else { title_lb.text = "Retail Dining" }
        return header_v
    }
    
    // Creates image view, could be more generic in future if more image views are needed
    func createImageView() -> UIImageView {
        let img_v = UIImageView()
        img_v.frame = CGRect(x: 14, y: 12, width: WIDTH * 0.32, height: WIDTH * 0.32 / 1.5)
        img_v.layer.cornerRadius = 7
        img_v.clipsToBounds = true
        img_v.contentMode = .scaleAspectFill
        return img_v
    }
    
}

// Colors from example
extension UIColor {
    @nonobjc class var black: UIColor {
        return UIColor(white: 31.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var azure: UIColor {
        return UIColor(red: 32.0 / 255.0, green: 156.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var greyish: UIColor {
        return UIColor(white: 169.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var greyishTwo: UIColor {
        return UIColor(white: 164.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var warmGrey: UIColor {
        return UIColor(white: 151.0 / 255.0, alpha: 1.0)
    }
}
