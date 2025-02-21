//
//  SongDetailsView.swift
//  FancySongs
//
//  Created by Della Anjeh on 2/20/25.
//


import SwiftUI

struct SongDetailsView: View {
    var song: Song
    @State private var isRotating = false
    @Environment(\.colorScheme) var colorScheme
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color.black : Color.white
    }
    
    private var accentGradient: LinearGradient {
        LinearGradient(
            colors: [.purple, .blue],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Artwork Section
            ZStack {
                Circle()
                    .fill(accentGradient)
                    .frame(width: 320, height: 320)
                    .blur(radius: 20)
                    .opacity(0.5)
                
                Circle()
                    .stroke(accentGradient, lineWidth: 2)
                    .frame(width: 310, height: 310)
                    .rotationEffect(.degrees(isRotating ? 360 : 0))
                    .animation(.linear(duration: 20).repeatForever(autoreverses: false), value: isRotating)
                
                AsyncImage(url: URL(string: song.artworkUrl100 ?? "https://hws.dev/img/logo.png")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(backgroundColor, lineWidth: 4)
                            )
                            .shadow(radius: 10)
                    } else if phase.error != nil {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                            Image(systemName: "music.note")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                        }
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 300, height: 300)
            }
            .padding(.top, 20)
            
            // Song Info Section
            VStack(spacing: 16) {
                Text(song.trackName)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundStyle(accentGradient)
                
                Text(song.collectionName)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                GenrePill(genreName: song.primaryGenreName)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .onAppear {
            isRotating = true
        }
    }
}

struct GenrePill: View {
    let genreName: String
    
    var body: some View {
        Text(genreName)
            .font(.system(.subheadline, design: .rounded))
            .fontWeight(.medium)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(LinearGradient(
                        colors: [.purple.opacity(0.8), .blue.opacity(0.8)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
            )
            .shadow(radius: 3)
    }
}

#Preview {
    SongDetailsView(song: Song.mock)
}
