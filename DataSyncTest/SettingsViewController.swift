//
//  SettingsViewController.swift
//  DataSyncTest
//
//  Created by Eric Theis on 7/18/14.
//  Copyright (c) 2014 PubNub. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var pubField: UITextField!
    @IBOutlet var subField: UITextField!
    @IBOutlet var authField: UITextField!
    
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pubField.text = self.appDelegate.pubKey
        subField.text = self.appDelegate.subKey
        authField.text = self.appDelegate.authKey
    }
    
    @IBAction func resetSubKey(sender: UITextField) {
        appDelegate.subKey = sender.text
    }
    
    @IBAction func resetPubKey(sender: UITextField) {
        appDelegate.pubKey = sender.text
    }
    
    @IBAction func resetAuthKey(sender: UITextField) {
        appDelegate.authKey = sender.text
    }
    
    @IBAction func resetConnection(sender: AnyObject) {
        PubNub.stopObjectSynchronization(appDelegate.sync_db)
        PubNub.disconnect()
        
        var myConfig = PNConfiguration(forOrigin: "pubsub-beta.pubnub.com", publishKey: appDelegate.pubKey, subscribeKey: appDelegate.subKey, secretKey: nil, authorizationKey: appDelegate.authKey)
        PubNub.setConfiguration(myConfig)
        
        PubNub.connect()
        PubNub.startObjectSynchronization(appDelegate.sync_db)
    }
}