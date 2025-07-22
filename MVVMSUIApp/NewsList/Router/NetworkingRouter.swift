//
//  HackerNewsRouter.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 21.07.2025.
//

import Foundation

enum NetworkingRouter {
    case bestStories
    case item(Int)

    var url: URL {
        switch self {
        case .bestStories:
            return URL(string: "https://hacker-news.firebaseio.com/v0/beststories.json")!
        case .item(let id):
            return URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!
        }
    }
}
