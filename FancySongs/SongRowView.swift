//
//  SongRowView.swift
//  FancySongs
//
//  Created by Della Anjeh on 2/20/25.
//

import SwiftUI

struct SongRowView: View {
    let song: Song
    @Environment(\.colorScheme) var colorScheme
    
    private var rowGradient: LinearGradient {
        LinearGradient(
            colors: [.purple.opacity(0.1), .blue.opacity(0.1)],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Album Artwork
            AsyncImage(url: URL(string: song.artworkUrl100 ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "music.note.circle.fill")
                        .foregroundStyle(LinearGradient(colors: [.purple, .blue],
                                                      startPoint: .topLeading,
                                                      endPoint: .bottomTrailing))
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 2)
            
            // Song Info
            VStack(alignment: .leading, spacing: 4) {
                Text(song.trackName)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundStyle(LinearGradient(colors: [.purple, .blue],
                                                  startPoint: .leading,
                                                  endPoint: .trailing))
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(song.collectionName)
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
            Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .semibold))
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? Color.black : Color.white)
                .overlay(rowGradient)
        )
        .contentShape(Rectangle())
    }
}

#Preview {
    SongRowView(song: Song.mock)
}

