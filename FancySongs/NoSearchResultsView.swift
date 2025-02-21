//
//  NoSearchResultsView.swift
//  FancySongs
//
//  Created by Della Anjeh on 2/20/25.
//

import SwiftUI

struct NoSearchResultsView: View {
    let searchText: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "music.note.list")
                .font(.system(size: 64))
                .foregroundStyle(LinearGradient(colors: [.purple, .blue],
                                              startPoint: .topLeading,
                                              endPoint: .bottomTrailing))
            
            Text("No matches found")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.semibold)
            
            Text("No songs match '\(searchText)'")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    NoSearchResultsView(searchText: "random")
}
