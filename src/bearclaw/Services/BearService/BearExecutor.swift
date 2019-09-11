//
//  BearCaller.swift
//  bearclaw
//
//  Created by Xavier Decuyper on 22/11/2017.
//  Copyright © 2017 Savjee. All rights reserved.
//

import Foundation
import Cocoa

class BearExecutor{
    func execute(_ action: BearAction) {
        if let url = action.toURL() {
            NSWorkspace.shared.open(url)
        } else {
            print("No URL to process")
        }
    }
}
