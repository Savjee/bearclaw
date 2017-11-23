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
    
    static func sendToBear(action: BearAction, arguments: [BearArgument]){
        var url = "bear://x-callback-url/\(action.rawValue)?"
        
        for (index, arg) in arguments.enumerated() {
            var value = arg.value
            
            // Encode special characters if we must
            if arg.encode == true {
                value = arg.value.addingPercentEncoding(withAllowedCharacters: CharacterSet.rfc3986Unreserved)!
            }
                        
            // The first element has to be appended without the "&"
            // but all others need it!
            if index > 0{
                url.append("&")
            }
            
            url.append("\(arg.field)=\(value)")
        }
        
        print(url)

        
        // Send it to Bear
        let nsURLObject = URL(string: url)
        NSWorkspace.shared.open(nsURLObject!)
    }
}

extension CharacterSet {
    static let rfc3986Unreserved = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~")
}
