//
//  ScreenshotCapture.swift
//  bearclaw
//
//  Created by Xavier Decuyper on 22/11/2017.
//  Copyright © 2017 Savjee. All rights reserved.
//

import Foundation
import Cocoa

class ScreenshotTool{
    
    
    public func captureFullscreen() -> String {
        let displayID = CGMainDisplayID()
        let imageRef = CGDisplayCreateImage(displayID)!
        let bitmapRep = NSBitmapImageRep(cgImage: imageRef)
        
        return getBase64(bitmapRepresentation: bitmapRep)
    }
    
    public func captureUserSelection() -> String {
        
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = [
            "screencapture",
            "-s", // only allow mouse selection mode
            "-x", // do not play sounds
            "-c" // force screen capture to go to the clipboard
        ]
        task.launch()
        task.waitUntilExit()
        
        if !task.isRunning {
            let status = task.terminationStatus
            
            if status == 0 {
                let img = NSImage(pasteboard: NSPasteboard.general)
                let rep = NSBitmapImageRep(data: (img?.tiffRepresentation)!)!
                
                
                return getBase64(bitmapRepresentation: rep)
            }
        }
        
        return ""
    }
    
    /**
     * Returns the base64 representation of an image (PNG) as String
     */
    private func getBase64(bitmapRepresentation: NSBitmapImageRep) -> String {
        return (bitmapRepresentation.representation(using: NSBitmapImageRep.FileType.png, properties: [:])?.base64EncodedString())!
    }
    
}
