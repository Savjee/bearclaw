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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func clickedOnFullScreenshotButton(_ sender: NSButton) {
        
        //let urlToOpen = "bear://x-callback-url/create?text=ho&file=\(self.TakeScreensShots())&filename=screenshot.jpg"
        //print(urlToOpen)
        //let nsURLObject = NSURL(string: urlToOpen)
        //NSWorkspace.shared.open(nsURLObject! as URL)
        
        //BearCommunicator().createNote(contents: "Screenshot taken on XXX",
        //                              fileName: "screenshot.jpg",
        //                              fileContents: self.TakeScreensShots())
        
        
        NewBearNote()
            .setContents("Screenshot taken on XXX")
            .setFile(fileName: "screenshot.jpg", fileContents: self.TakeScreensShots())
            .sendToBear()
        
    }
    
    @IBAction func clickedOnSaveToBear(_ sender: NSButton) {
        NewBearNote()
            .setContents(self.textView.string)
            .sendToBear()
        
        //BearCommunicator().createNote(contents: self.textView.string)
        self.textView.textStorage?.mutableString.setString("")
    }
    
    func TakeScreensShots() -> String{
        
        let displayID = CGMainDisplayID()
        let imageRef = CGDisplayCreateImage(displayID)!
        let bitmapRep = NSBitmapImageRep(cgImage: imageRef)
        let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])!

        return jpegData.base64EncodedString()
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
