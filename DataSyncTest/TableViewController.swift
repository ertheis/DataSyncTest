//
//  TableViewController.swift
//  DataSyncTest
//
//  Created by Eric Theis on 7/16/14.
//  Copyright (c) 2014 PubNub. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView
    
    override func viewDidLoad() {
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        super.viewDidLoad()
    }
    
    func getTableData() -> [String] {
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.syncedData as [String]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return  self.getTableData().count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        var toggle = UISwitch()
        toggle.addTarget(self, action: Selector("switchToggled:"), forControlEvents: UIControlEvents.ValueChanged)
        toggle.tintColor = UIColor.redColor()
        toggle.tag = indexPath.row
        
        if toggle.on {
            cell.textLabel.text = "\(self.getTableData()[indexPath.row]): unlocked"
        } else {
            cell.textLabel.text = "\(self.getTableData()[indexPath.row]): locked"
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.accessoryView = toggle
        
        return cell
    }
    
    @IBAction func switchToggled(toggle: UISwitch) {
        var cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: toggle.tag, inSection: 0))
        
        if toggle.on {
            cell.textLabel.text = "\(self.getTableData()[toggle.tag]): unlocked"
        } else {
            cell.textLabel.text = "\(self.getTableData()[toggle.tag]): locked"
        }
    }
}