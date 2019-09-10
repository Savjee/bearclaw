//
//  BearAction.swift
//  bearclaw
//
//  Created by Xavier Decuyper on 23/11/2017.
//  Copyright © 2017 Savjee. All rights reserved.
//

import Foundation

struct FileParameter {
    let fileContent: String
    let filename: String
}
enum BearAction {
    case addFile
    case createNote(title: String?, text: String?, file: FileParameter? )

    var URLComponent: String {
        switch self {
        case .addFile:
            return "add-file"
        case .createNote:
            return "create"
        }
    }
}

extension BearAction {
    func run() {
        
    }
}
