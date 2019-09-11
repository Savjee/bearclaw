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
        
        // Make sure that the text color is dynamically set by the system
        // This is only required for older macOS versions.
        textView.textColor = NSColor.headerTextColor;
        
        // Focus directly on the textview
        textView.window?.makeFirstResponder(textView)
        
        NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.keyDown, handler: handleKeyboardEvent(_:))
    }
    
    override func viewDidAppear() {
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    @IBAction func clickedOnFullScreenshotButton(_ sender: NSButton) {
        AppDelegate.popoverInstance.close()

        let noteTitle = generateNameForScreenshot()
        let base64Image = ScreenshotTool().captureFullscreen()
        guard !base64Image.isEmpty else { return }

        let file = FileParameter(fileContent: base64Image,
                                 filename: noteTitle)
        let action = BearAction.createNote(title: noteTitle, text: nil, file: file)
        BearExecutor().execute(action)
    }
    
    @IBAction func clickedOnSettingsButton(_ sender: NSButton) {
        settingsMenu.popUp(positioning: settingsMenu.item(at: 0), at: NSEvent.mouseLocation, in: nil)
    }
    
    @IBAction func clickedOnPartialScreenshotButton(_ sender: NSButton) {
        AppDelegate.popoverInstance.close()

        let noteTitle = generateNameForScreenshot()
        let base64Image = ScreenshotTool().captureUserSelection()
        guard !base64Image.isEmpty else { return }

        let file = FileParameter(fileContent: base64Image,
                                 filename: noteTitle)
        let action = BearAction.createNote(title: noteTitle, text: nil, file: file)
        BearExecutor().execute(action)
    }
    
    @IBAction func clickedOnSaveToBear(_ sender: Any) {
        AppDelegate.popoverInstance.close()

        let action = BearAction.createNote(title: nil, text: self.textView.string, file: nil)
        BearExecutor().execute(action)

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
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        //2.
        let identifier = "ClipperViewController"
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ClipperViewController else {
            fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
        }
        
        return viewcontroller
    }
}
