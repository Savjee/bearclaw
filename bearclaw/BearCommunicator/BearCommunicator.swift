//
//  BearCaller.swift
//  bearclaw
//
//  Created by Xavier Decuyper on 22/11/2017.
//  Copyright © 2017 Savjee. All rights reserved.
//

import Foundation
import Cocoa

class BearCommunicator{
    
    static func sendToBear(arguments: [BearArgument]){
        var url = "bear://x-callback-url/create?"
        
        
        for (index, arg) in arguments.enumerated() {
            var value = arg.value
            
            // Encode special characters if we must
            if arg.encode == true {
                value = arg.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            }
            
            // The first element has to be appended without the "&"
            // but all others need it!
            if index > 0{
                url.append("&")
            }
            
            url.append("\(arg.field)=\(value)")
        }
        
        // Send it to Bear
        let nsURLObject = URL(string: url)
        NSWorkspace.shared.open(nsURLObject!)
    }
}




