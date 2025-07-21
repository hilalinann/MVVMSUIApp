//
//  HackerNewsRouter.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 21.07.2025.
//

import Foundation

import Foundation

enum HackerNewsRouter {
    
    case allNews

    var url: URL? {
        switch self {
        case .allNews:
            return URL(string: "")
        }
    }
}
