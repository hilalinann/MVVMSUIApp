//
//  AppRouter.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 22.07.2025.
//

import Foundation

import SwiftUI

struct AppRouter {
    func view(for route: Route) -> some View {
        switch route {
        case .newsDetail(let news):
            return AnyView(DetailView(news: news))
        }
    }
}

let router = AppRouter()
