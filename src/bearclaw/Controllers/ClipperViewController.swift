//
//  ClipperViewController.swift
//  bearclaw
//
//  Created by Xavier Decuyper on 22/11/2017.
//  Copyright © 2017 Savjee. All rights reserved.
//

import Cocoa

class ClipperViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    @IBOutlet var settingsMenu: NSMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style the textView
        textView.font = NSFont(name: "Avenir Next", size: 15)
        textView.textContainerInset = NSMakeSize(10, 10)
        
        // Focus directly on the textview
        textView.window?.makeFirstResponder(textView)
        
        NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.keyDown, handler: handleKeyboardEvent(_:))
    }
    
    override func viewDidAppear() {
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    @IBAction func clickedOnFullScreenshotButton(_ sender: NSButton) {
        AppDelegate.popoverInstance.close()
        
        NewBearNote()
            .setFile(fileName: generateNameForScreenshot(), fileContents: ScreenshotTool().captureFullscreen())
            .setAction(BearAction.createNote)
            .setTitle(generateNameForScreenshot())
            .sendToBear()
    }
    
    @IBAction func clickedOnSettingsButton(_ sender: NSButton) {
        settingsMenu.popUp(positioning: settingsMenu.item(at: 0), at: NSEvent.mouseLocation, in: nil)
    }
    
    @IBAction func clickedOnPartialScreenshotButton(_ sender: NSButton) {
        AppDelegate.popoverInstance.close()
        
        let base64Image = ScreenshotTool().captureUserSelection()
        
        if base64Image != ""{
            NewBearNote()
                .setFile(fileName: generateNameForScreenshot(), fileContents: base64Image)
                .setAction(BearAction.createNote)
                .setTitle(generateNameForScreenshot())
                .sendToBear()
        }
        
    }
    
    @IBAction func clickedOnSaveToBear(_ sender: Any) {
        AppDelegate.popoverInstance.close()

        NewBearNote()
            .setContents(self.textView.string)
            .setAction(BearAction.createNote)
            .sendToBear()
        
        // Reset the textView
        self.textView.textStorage?.mutableString.setString("")
    }
    
    
    func generateNameForScreenshot() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd_HH.mm.ss"
        
        return "Screenshot_" + dateFormatter.string(from: Date()) + ".png"
    }
    
    func handleKeyboardEvent(_ event: NSEvent) -> NSEvent{
        
        // cmd + return -> save
        if event.modifierFlags.contains(NSEvent.ModifierFlags.command){
            if event.keyCode == 36{
                clickedOnSaveToBear("")
            }
        }
        
        // Escape key
        if event.keyCode == 53{
            AppDelegate.popoverInstance.close()
        }
        
        return event
    }
}

extension ClipperViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> ClipperViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "ClipperViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ClipperViewController else {
            fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
        }
        
        return viewcontroller
    }
}
