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

    let contextMenu = NSMenu()
    let statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)

    func startService() {
        print("Do not disturb started")
    }
    
    func quitApplication() {
        NSApplication.shared().terminate(self)
    }
    
    func statusBarButtonClicked(sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        
        if event.type == NSEventType.rightMouseUp {
            statusItem.menu = contextMenu
            statusItem.popUpMenu(contextMenu)
            statusItem.menu = nil
        } else {
            startService()
            
            if let button = statusItem.button {
                button.image = NSImage(named: "DndStatusBarButtonImage")
            }
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        contextMenu.addItem(NSMenuItem(title: "Start Do Not Disturb", action: #selector(self.startService), keyEquivalent: "P"))
        contextMenu.addItem(NSMenuItem.separator())
        contextMenu.addItem(NSMenuItem(title: "Quit", action:
            #selector(self.quitApplication), keyEquivalent: "q"))
        
        if let button = statusItem.button {
            button.image = NSImage(named: "DisturbStatusBarButtonImage")
            button.action = #selector(self.statusBarButtonClicked(sender:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

