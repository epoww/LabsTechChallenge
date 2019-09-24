//
//  ViewController.swift
//  LabsChallenge
//
//  Created by Elizabeth Powell on 9/22/19.
//  Copyright © 2019 Elizabeth Powell. All rights reserved.
//

import WebKit
import UIKit

var HEIGHT : CGFloat!
var WIDTH : CGFloat!

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var helper = Helper() // helper that can access helper functions, mainly date and formatting ones
    var networkManager = NetworkManager() // network manager takes care of url calls
    var UIcreator = Creator() // UI creator has can access functions to make the UI
    
    // a list of residential dining halls (swipes), whenever updated should reload the tableview data
    var DiningHalls = [DiningPlace]() {
        didSet {
            DispatchQueue.main.async {
                self.tbv.reloadData()
            }
        }
    }
    
    // a list of retail dining halls (dining dollars), whenever updated should reload the tableview data
    var RetailDining = [DiningPlace]() {
        didSet {
            DispatchQueue.main.async {
                self.tbv.reloadData()
            }
        }
    }
    
    // handles closing the webView
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    // table view has 2 sections, one for residential dining halls and one for retail dining halls
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // section 0 -> residential dining halls, section 1 -> retail dining halls
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return DiningHalls.count }
        return RetailDining.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        // get dining place object for this cell
        let diningHall: DiningPlace!
        if section == 0 { diningHall = DiningHalls[indexPath.item] }
        else { diningHall = RetailDining[indexPath.item] }
        
        // display dining hall name and place holder gray background
        let cell = tableView.dequeueReusableCell(withIdentifier: "dining cell") as! DiningTableViewCell
        cell.name_lb.text = diningHall.name
        cell.img_v.backgroundColor = UIColor.lightGray
        
        // asynchronously display dining hall image
        if let url = URL(string: diningHall.imageURL) {
            networkManager.getImage(url: url, completionHandler: {
                image in
                DispatchQueue.main.async(execute: {
                    cell.img_v.image = image
                })
            })
        }
        
        // display dining hall hours
        var hours = ""
        var open = false
        (hours, open) = diningHall.getHours(helper: helper)
        cell.hours_lb.text = hours
        
        // display dining hall status (open or closed)
        if open {
            cell.status_lb.text = "OPEN"
            cell.status_lb.textColor = UIColor.azure
        }
        else {
            cell.status_lb.text = "CLOSED"
            cell.status_lb.textColor = UIColor.greyish
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WIDTH * 0.32 / 1.5 + 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIcreator.createHeaderView(section: section)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    // when a cell is selected, open webview and go to the dining hall's facility url
    // run activity indicator while the page loads
    var selectedIndexPath = IndexPath()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let url: URL!
        if section == 0 {
            url = URL(string: DiningHalls[indexPath.item].facilityURL)
        } else {
            url = URL(string: RetailDining[indexPath.item].facilityURL)
        }
        
        selectedIndexPath = indexPath
        webv.load(URLRequest(url: url!))
        self.view.addSubview(webv)
        self.view.addSubview(activityIndicator)
        self.view.addSubview(close_btn)
        activityIndicator.startAnimating()
        
        webv.alpha = 0
        close_btn.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.webv.alpha = 1
            self.close_btn.alpha = 0.6
        }
        
    }
    
    var tbv: UITableView!
    var webv: WKWebView!
    var date_lb: UILabel!
    var activityIndicator: UIActivityIndicatorView!
    var close_btn: UIButton!
    // sets up the main page's UI
    func setUpUI() {
        tbv = UIcreator.tbvCreator()
        date_lb = UIcreator.createLabel(x: 14, y: 63, width: 200, height: 15, fontName: "Arial-BoldMT", fontSize: 12, textColor: UIColor.greyishTwo)
        webv = UIcreator.webVCreator()
        activityIndicator = UIcreator.createActivityIndicator()
        close_btn = UIcreator.createCloseWebViewButton()
        
        tbv.dataSource = self
        tbv.delegate = self
        activityIndicator.center = self.view.center
        close_btn.addTarget(self, action: #selector(closeWebView), for: .touchUpInside)

        self.view.addSubview(tbv)
        self.view.addSubview(date_lb)
    }
    
    // function called when user closes the webview
    @objc func closeWebView() {
        close_btn.removeFromSuperview()
        webv.removeFromSuperview()
        webv.load(URLRequest(url: URL(string:"about:blank")!))
        activityIndicator.stopAnimating()
        tbv.deselectRow(at: selectedIndexPath, animated: true)
        UIView.animate(withDuration: 0.3) {
            self.webv.alpha = 0
            self.close_btn.alpha = 0
        }
    }
    
    // each time the user views the app, it should update the times and status of dining halls
    override func viewWillAppear(_ animated: Bool) {
        date_lb.text = helper.getDateWithDay()
        
        if let url = URL(string: "http://api.pennlabs.org/dining/venues") {
            networkManager.getData(url: url, completionHandler: {
                (diningHall, retailDining) in
                (self.DiningHalls, self.RetailDining) = (diningHall, retailDining)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HEIGHT = self.view.frame.height
        WIDTH = self.view.frame.width
        
        setUpUI()
    }
}

