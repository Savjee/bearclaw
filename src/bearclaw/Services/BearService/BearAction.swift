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
}

extension BearAction {
    func toPathComponent() -> String {
        switch self {
        case .addFile:
            return "/add-file"
        case .createNote:
            return "/create"
        }
    }

    func toURL() -> URL? {
        var urlComponents = URLComponents()
        var queryParameters: [URLQueryItem] = []

        urlComponents.scheme = "bear"
        urlComponents.host = "x-callback-url"
        urlComponents.path = toPathComponent()

        switch self {
        case .addFile:
            break
        case .createNote(let title, let text, let file):
            if let title = title {
                queryParameters.append(URLQueryItem(name: "title", value: title))
            }
            if let text = text {
                queryParameters.append(URLQueryItem(name: "text", value: text))
            }
            if let file = file {
                queryParameters.append(URLQueryItem(name: "file", value: file.fileContent))
                queryParameters.append(URLQueryItem(name: "filename", value: file.filename))
            }
        }
        urlComponents.queryItems = queryParameters
        return urlComponents.url
    }
}
