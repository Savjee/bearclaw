//
//  BearAction.swift
//  bearclaw
//
//  Created by Xavier Decuyper on 23/11/2017.
//  Copyright © 2017 Savjee. All rights reserved.
//

import Foundation

enum BearAction {
    case addFile
    case createNote

    var URLComponent: String {
        switch self {
        case .addFile:
            return "add-file"
        case .createNote:
            return "create"
        }
    }
}
