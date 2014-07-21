//
//  Switch View Controller.swift
//  DataSyncTest
//
//  Created by Eric Theis on 7/17/14.
//  Copyright (c) 2014 PubNub. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController {
    
    @IBOutlet var doorSwitch: UIButton!
    @IBOutlet var lightSwitch: UIButton!
    @IBOutlet var musicSwitch: UIButton!
    @IBOutlet var garageSwitch: UIButton!
    
    override func viewDidLoad() {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var myConfig = PNConfiguration(forOrigin: "pubsub-beta.pubnub.com", publishKey: appDelegate.pubKey, subscribeKey: appDelegate.subKey, secretKey: nil, authorizationKey: appDelegate.authKey)
        PubNub.setConfiguration(myConfig)
        PubNub.connect()
        
        PubNub.startObjectSynchronization(appDelegate.sync_db)
        
        PNObservationCenter.defaultCenter().addObjectSynchronizationStartObserver(self) { (syncObject: PNObject!, error: PNError!) in
            if !error {
                self.updateAllSwitches(syncObject)
            } else {
                println("OBSERVER: \(error.code)")
                println("OBSERVER: \(error.description)")
            }
        }
        
        PNObservationCenter.defaultCenter().addObjectChangeObserver(self) { (syncObject: PNObject!) in
            self.updateAllSwitches(syncObject)
        }
        
        super.viewDidLoad()
    }
    
    func updateAllSwitches(syncObject: PNObject) {
        if let lightOn = syncObject.objectForKey("light") as? Int {
            self.lightSwitch.tag = lightOn
            self.updateSwitch(self.lightSwitch, type: "Lights")
        }
        if let doorOn = syncObject.objectForKey("door") as? Int {
            self.doorSwitch.tag = doorOn
            self.updateSwitch(self.doorSwitch, type: "Doors")
        }
        if let musicOn = syncObject.objectForKey("music") as? Int {
            self.musicSwitch.tag = musicOn
            self.updateSwitch(self.musicSwitch, type: "Music")
        }
        if let garageOn = syncObject.objectForKey("garage") as? Int {
            self.garageSwitch.tag = garageOn
            self.updateSwitch(self.garageSwitch, type: "Car")
        }
    }
    
    @IBAction func doorSwitch(sender: UIButton) {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if sender.tag == 0 {
            sender.tag = 1
            PubNub.updateObject(appDelegate.sync_db, withData: ["door":1])
        } else {
            sender.tag = 0
            PubNub.updateObject(appDelegate.sync_db, withData: ["door":0])
        }
        updateSwitch(sender, type: "Doors")
    }
    
    @IBAction func lightSwitch(sender: UIButton) {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if sender.tag == 0 {
            sender.tag = 1
            PubNub.updateObject(appDelegate.sync_db, withData: ["light":1])
        } else {
            sender.tag = 0
            PubNub.updateObject(appDelegate.sync_db, withData: ["light":0])
        }
        updateSwitch(sender, type: "Lights")
    }
    
    @IBAction func musicSwitch(sender: UIButton) {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if sender.tag == 0 {
            sender.tag = 1
            PubNub.updateObject(appDelegate.sync_db, withData: ["music":1])
        } else {
            sender.tag = 0
            PubNub.updateObject(appDelegate.sync_db, withData: ["music":0])
        }
        updateSwitch(sender, type: "Music")
    }
    
    @IBAction func garageSwitch(sender: UIButton) {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if sender.tag == 0 {
            sender.tag = 1
            PubNub.updateObject(appDelegate.sync_db, withData: ["garage":1])
        } else {
            sender.tag = 0
            PubNub.updateObject(appDelegate.sync_db, withData: ["garage":0])
        }
        updateSwitch(sender, type: "Car")
    }
    
    func syncUpdateCompletionHandler(mods: PNObjectModificationInformation!, error: PNError!) {
        if error {
            println(error.description)
        }
    }
    
    func updateSwitch(button: UIButton, type: String) {
        if button.tag == 0 {
            button.setImage(UIImage(named: "PubNub\(type)Red"), forState: UIControlState.Normal)
        } else {
            button.setImage(UIImage(named: "PubNub\(type)Green"), forState: UIControlState.Normal)
        }
    }
}