//
//  Song.swift
//  FancySongs
//
//  Created by Della Anjeh on 2/20/25.
//

import SwiftUI

struct Song: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
    var artworkUrl100: String?
    var primaryGenreName: String
    var releaseDate: String
    
    static var mock: Song {
        Song(trackId: 4, trackName: "This is a song", collectionName: "This is an album", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music128/v4/4f/d1/6c/4fd16cb6-3681-1e74-bca9-8ccec1c0f15d/8718522182624.png/100x100bb.jpg", primaryGenreName: "Trance", releaseDate: "")
    }
}

