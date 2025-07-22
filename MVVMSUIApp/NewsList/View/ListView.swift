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

    var body: some View {
        NavigationStack {
            List(viewModel.newsList) { news in
                NavigationLink(value: Route.newsDetail(news)) {
                    Entry(story: news)
                    .padding(.vertical, 4)
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

extension Entry {
    init(story: HackerNews) {
        self.title = story.title
        self.score = story.score
        self.commentCount = story.commentCount ?? 0
        self.author = story.author
        
        let host = story.url?.hostName() ?? ""
        let date = story.date?.timeAgoDisplay() ?? ""
        self.footnote = "\(host) – \(date) – by \(story.author)"
    }
}
