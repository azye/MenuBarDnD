//
//  AppDelegate.swift
//  MenuBarDnD
//
//  Created by Alex Z.Y. Ye on 12/31/16.
//  Copyright © 2016 Alex Z.Y. Ye. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    
    func startService() {
        print("Application clicked")
    }
    
    func quitApplication() {
        NSApplication.shared().terminate(self)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
//            button.action = #selector(self.printStatus)
        }
        
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Start Do Not Disturb", action: #selector(self.startService), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(self.quitApplication), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    }

