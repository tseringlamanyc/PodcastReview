//
//  Podcast.swift
//  PodcastReview
//
//  Created by Tsering Lama on 12/16/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

struct PodcastData: Codable {
    
    let results: [Podcast]
}

struct Podcast: Codable {
    
    let artistName: String
    let trackId: Int 
    let collectionName: String
    let artworkUrl600: String
    let artworkUrl100: String
    let primaryGenreName: String
    
}
