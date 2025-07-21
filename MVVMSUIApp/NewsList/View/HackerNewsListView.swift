//
//  ContentView.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 21.07.2025.
//

import SwiftUI

struct HackerNewsListView: View {
    @StateObject private var viewModel = HNListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.newsList) { news in
                NavigationLink(destination: NewsDetailView(news: news)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(news.title)
                            .font(.headline)
                        Text("Yazan: \(news.author) | Skor: \(news.score) | Yorum: \(news.commentCount)")
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

        }
    }
}
