//
//  SettingsMenuController.swift
//  bearclaw
//
//  Created by Xavier Decuyper on 22/11/2017.
//  Copyright © 2017 Savjee. All rights reserved.
//

import Cocoa

class SettingsMenuController : NSMenu{
    
    @IBAction func quitItemClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    
    @IBAction func aboutItemClicked(_ sender: NSMenuItem) {
        AppDelegate.popoverInstance.close()
        NSApplication.shared.orderFrontStandardAboutPanel(sender)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
}
