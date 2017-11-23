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
    }
    
    @IBAction func clickedOnFullScreenshotButton(_ sender: NSButton) {
        AppDelegate.popoverInstance.close()
        
        NewBearNote()
            .setContents(generateNameForScreenshot())
            .setFile(fileName: "screenshot.png", fileContents: ScreenshotTool().captureFullscreen())
            .sendToBear()
    }
    
    @IBAction func clickedOnSettingsButton(_ sender: NSButton) {
        settingsMenu.popUp(positioning: settingsMenu.item(at: 0), at: NSEvent.mouseLocation, in: nil)
    }
    
    @IBAction func clickedOnPartialScreenshotButton(_ sender: NSButton) {
        AppDelegate.popoverInstance.close()

        NewBearNote()
            .setContents(generateNameForScreenshot())
            .setFile(fileName: "screenshot.png", fileContents: ScreenshotTool().captureUserSelection())
            .sendToBear()
    }
    
    func generateNameForScreenshot() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd_HH.MM.ss"
        
        return "Screenshot_" + dateFormatter.string(from: Date()) + ".png"
    }
    
    
    @IBAction func clickedOnSaveToBear(_ sender: NSButton) {
        AppDelegate.popoverInstance.close()


        NewBearNote()
            .setContents(self.textView.string)
            .sendToBear()
        
        // Reset the textView
        self.textView.textStorage?.mutableString.setString("")
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
