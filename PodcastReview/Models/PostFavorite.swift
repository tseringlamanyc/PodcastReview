//
//  PostFavorite.swift
//  PodcastReview
//
//  Created by Tsering Lama on 12/17/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

struct PostFavorite: Codable {
    
    let trackId : Int
    let favoritedBy: String
    let collectionName : String
    let artworkUrl600 : String
    
}
