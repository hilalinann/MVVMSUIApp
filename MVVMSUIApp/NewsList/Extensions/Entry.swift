//
//  Entry.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 22.07.2025.
//

import Foundation
import SwiftUI

struct Entry: View {
    let title: String
    let score: Int
    let commentCount: Int
    let footnote: String
    let author: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            Text(footnote)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack(spacing: 16) {
                Label("\(score)", systemImage: "arrowtriangle.up.circle.fill")
                    .foregroundColor(.blue)
                Label("\(commentCount)", systemImage: "bubble.right.fill")
                    .foregroundColor(.orange)
            }
            .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
}
