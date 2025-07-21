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
            Text("Skor: \(news.score) | Yorum: \(news.commentCount)")
            
            Link("Haberi Oku", destination: news.url)
                .font(.headline)
                .foregroundColor(.blue)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detay")
    }
}
