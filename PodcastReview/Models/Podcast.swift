//
//  Podcast.swift
//  PodcastReview
//
//  Created by Tsering Lama on 12/16/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

struct PodcastData: Decodable {
    
    let results: [Podcast]
}

struct Podcast: Decodable {
    
    let artistName: String
    let collectionName: String
    let artworkUrl600: String
    let artworkUrl100: String
    let primaryGenreName: String
    
}
