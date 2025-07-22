//
//  ContentView.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 21.07.2025.
//

// HackerNewsListView.swift

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = HNViewModel()
    @State private var selectedRoute: Route?

    var body: some View {
        NavigationStack {
            List(viewModel.newsList) { news in
                NavigationLink(value: Route.newsDetail(news)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(news.title)
                            .font(.headline)
                        Text("Yazan: \(news.author) | Skor: \(news.score) | Yorum: \(news.commentCount ?? 0)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Hacker News")
            .onAppear {
                viewModel.fetchBestStories()
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text("Hata"), message: Text(error.message), dismissButton: .default(Text("Tamam")))
            }
            .navigationDestination(for: Route.self) { route in
                router.view(for: route)
            }
        }
    }
}
