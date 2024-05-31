/*********************************************************
 * (c) Copyright 2022. All Rights Reserved
 * LG Soft India Pvt. Ltd.
 * Bengaluru - 560103
 * India.
 *
 * Project Name : Switch App [macOS]
 * Group             : BDS-IT
 * Security          : Confidential
 *******************************************************/

/*********************************************************
 * Filename             : SwiftGenericHelper
 * Purpose              : Helper methods which can be reused across modules
 * Platform             : macOS
 * Author(s)            : Chethan Kumar
 * E-mail id            : chethan18.kumar@lge.com
 * Creation date        : Jun 23, 2022
 *********************************************************/

import Cocoa

class SwiftGenericHelper: NSObject {
    
    /**
     Checks if dock/menu is hidden
     - important: In this method it checks if dock/menu is already hidden or not.
     - Author: Chethan Kumar C
     - returns: true if hidden, else false
     */
    @objc public static func isDockAndMenuBarHidden() -> Bool {
        let application = NSApplication.shared
        let autoHidden = application.presentationOptions.contains(.autoHideMenuBar)
        return autoHidden
    }
    
    /**
     Hides or unhides the Menu and Dock bar
     - important: In this method it checks if menu is already hidden or not. If not hidden, it updates the app presentation to auto hide Menu and Dock bar. If hidden it removes auto hide presentation option from application.
     - Author: Chethan Kumar C
     - returns: Nothing
     */
    @objc public static func toggleMenuAndDock() {
        let application = NSApplication.shared
        let autoHidden = application.presentationOptions.contains(.autoHideMenuBar)
        
        if autoHidden {
            application.presentationOptions = []
        } else {
            application.presentationOptions = [.autoHideDock, .autoHideMenuBar]
        }
    }
    
    /**
     Hides the Menu and Dock bar
     - important: In this method it updates the app presentation to auto hide Menu and Dock bar for application.
     - Author: Chethan Kumar C
     - returns: Nothing
     */
    @objc public static func hideMenuAndDock() {
        let application = NSApplication.shared
        application.presentationOptions = [.autoHideDock]
    }
    
    /**
     Unhides the Menu and Dock bar
     - important: In this method it removes auto hide presentation option for application.
     - Author: Chethan Kumar C
     - returns: Nothing
     */
    @objc public static func unhideMenuAndDock() {
        let application = NSApplication.shared
        application.presentationOptions = []
    }
    
    /**
     Finds the screen instance for active window
     - important: In this method it finds the screen instance for the active window
     - Author: Chethan Kumar C
     - returns: NSScreen instance for the active window
     */
    @objc public static func findScreenForActiveWindow() -> NSScreen {
        // Get the app that currently has the focus.
        let frontApp = NSWorkspace.shared.frontmostApplication!
        
        // With this procedure, we get all available windows.
        let options = CGWindowListOption(arrayLiteral: CGWindowListOption.excludeDesktopElements, CGWindowListOption.optionOnScreenOnly)
        let windowListInfo = CGWindowListCopyWindowInfo(options, CGWindowID(0))
        let windowInfoList = windowListInfo as NSArray? as? [[String: AnyObject]]
        
        var screenResult = NSScreen.main
        
        for info in windowInfoList! {
            let windowPID = info["kCGWindowOwnerPID"] as! UInt32
            if  windowPID == frontApp.processIdentifier {
                let windowID = info["kCGWindowNumber"] as! Int32
                
                let window = Window(number: Int32(windowID))
                                
                // To avoid crash while unwrapping the value
                if nil == window {
                    continue
                } else {
                    for screen in NSScreen.screens {
                        let res = window!.belong(to: screen)
                        if res {
                            screenResult = screen
                            break
                        }
                    }
                }
            }
        }
        
        return screenResult!
    }
    
    /**
     Performs mouse click
     - important: In this method we will be performing mouse click at the mouse points sent
     - Author: Gagana K S
     */
    @objc public static func performMouseClick(x: CGFloat, y: CGFloat) {
        let mouseLocation = CGPoint(x: x, y: y)
        
        let mouseDownEvent = NSEvent.mouseEvent(with: .leftMouseDown, location: mouseLocation, modifierFlags: [], timestamp: 0, windowNumber: 0, context: nil, eventNumber: 0, clickCount: 1, pressure: 1.0)
        NSApplication.shared.postEvent(mouseDownEvent!, atStart: true)
        
        let mouseUpEvent = NSEvent.mouseEvent(with: .leftMouseUp, location: mouseLocation, modifierFlags: [], timestamp: 0, windowNumber: 0, context: nil, eventNumber: 0, clickCount: 1, pressure: 1.0)
        NSApplication.shared.postEvent(mouseUpEvent!, atStart: true)
    }
    
    @objc public static func fetchVersionNumber() -> String {
        var appVersionNumber = String()
        let applicationVersionINfo = "LG Switch V"
        let applicationCopyRightInfo = "Copyright 2022-2032 LG Electronics Inc."

        
        if let temp = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            appVersionNumber = "\(applicationVersionINfo) \(temp) \(applicationCopyRightInfo)"
        }

        return appVersionNumber
    }
}
