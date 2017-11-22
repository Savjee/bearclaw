//
//  NewBearNote.swift
//  bearclaw
//
//  Created by Xavier Decuyper on 22/11/2017.
//  Copyright © 2017 Savjee. All rights reserved.
//

import Foundation

class NewBearNote{
    
    var arguments = [BearArgument]()
    
    func setTitle(_ title: String) -> NewBearNote {
        arguments.append(BearArgument(field: "title", value: title, encode: true))
        return self
    }
    
    func setContents(_ contents: String) -> NewBearNote {
        arguments.append(BearArgument(field: "text", value: contents, encode: true))
        return self
    }
    
    func setFile(fileName: String, fileContents: String) -> NewBearNote {
        arguments.append(BearArgument(field: "filename", value: fileName, encode: true))
        arguments.append(BearArgument(field: "file", value: fileContents, encode: true))
        return self
    }
    
    func sendToBear(){
        BearCommunicator.sendToBear(arguments: self.arguments)
    }
}
