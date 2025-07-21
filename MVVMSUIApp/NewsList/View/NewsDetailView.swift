//
//  NewsDetailView.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 22.07.2025.
//

import Foundation
import SwiftUI

struct NewsDetailView: View {
    let news: HackerNews
    
    var body: some View {
        VStack(spacing: 16) {
            Text(news.title)
                .font(.title)
                .bold()
            Text("Yazan: \(news.author)")
            Text("Skor: \(news.score) | Yorum: \(news.commentCount ?? 0)")
            
            if let url = news.url {
                Link("Haberi Oku", destination: url)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detay")
    }
}
