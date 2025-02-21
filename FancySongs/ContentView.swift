//
//  ContentView.swift
//  FancySongs
//
//  Created by Della Anjeh on 2/20/25.
//

import SwiftUI

struct Response: Codable {
    var results: [Song]
}

struct ContentView: View {
    
    @State private var results = [Song]()
    @State private var searchText = ""
    @Environment(\.colorScheme) var colorScheme

    var filteredSongs: [Song] {
        if searchText.isEmpty {
            return results
        }
        return results.filter { song in
            song.trackName.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if !searchText.isEmpty && filteredSongs.isEmpty {
                    NoSearchResultsView(searchText: searchText)
                } else {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredSongs, id: \.trackId) { song in
                            NavigationLink {
                                SongDetailsView(song: song)
                            } label: {
                                SongRowView(song: song)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
            .task {
                await loadData()
            }
            .navigationTitle("Songs")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText,  placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search songs"
            )
        }
    }

    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=denis+kenzo&entity=song")
        else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            if let decodedResponse = try? decoder.decode(Response.self, from: data) {
                results = decodedResponse.results
                print(results)
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}

