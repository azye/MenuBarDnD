//
//  AppDelegate.swift
//  MenuBarDnD
//
//  Created by Alex Z.Y. Ye on 12/31/16.
//  Copyright © 2016 Alex Z.Y. Ye. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var window: NSWindow!
    var dndIsActive: Bool = false
    let contextMenu = NSMenu()
    let statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    let options : NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
    
    func runScript() {
        if let path = Bundle.main.path(forResource: "dnd", ofType:"scpt") {
            let task = Process()
            task.launchPath = "/usr/bin/osascript"
            task.arguments = [path]
            task.launch()
        }
    }
    
    func toggleService() {
        if dndIsActive {
            if let button = statusItem.button {
                button.image = NSImage(named: "DisturbStatusBarButtonImage")
            }
            print("Do not disturb has been turned off")
            dndIsActive = false
        } else {
            if let button = statusItem.button {
                button.image = NSImage(named: "DndStatusBarButtonImage")
            }
            print("Do not disturb has been turned on")
            dndIsActive = true
        }
        
        self.runScript()
    }
    
    func midnightCheck() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let defaults = UserDefaults(suiteName: "com.apple.notificationcenterui")
            let state = defaults?.bool(forKey: "doNotDisturb") ?? false
            
            if state != self.dndIsActive {
                self.runScript()
            }
        }
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
            let accessibilityEnabled = AXIsProcessTrustedWithOptions(options)
            if accessibilityEnabled {
                toggleService()
            }
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        contextMenu.addItem(NSMenuItem(title: "Toggle Do Not Disturb", action: #selector(self.toggleService), keyEquivalent: "P"))
        contextMenu.addItem(NSMenuItem.separator())
        contextMenu.addItem(NSMenuItem(title: "Quit", action:
            #selector(self.quitApplication), keyEquivalent: "q"))
        
        let theDefaults = UserDefaults(suiteName: "com.apple.notificationcenterui")
        let initialState = theDefaults?.bool(forKey: "doNotDisturb") ?? false
        
        if initialState {
            dndIsActive = true
            print("DnD is enabled on app startup.")
        } else {
            print("DnD is disabled on app startup.")
        }

        if let button = statusItem.button {
            if dndIsActive {
                button.image = NSImage(named: "DndStatusBarButtonImage")
            } else {
                button.image = NSImage(named: "DisturbStatusBarButtonImage")
            }
            button.action = #selector(self.statusBarButtonClicked(sender:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        
        let dayChangeNotification = Notification.Name.NSCalendarDayChanged
        NotificationCenter.default.addObserver(self, selector: #selector(self.midnightCheck), name: dayChangeNotification, object: nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

