//
//  PodcastAPI.swift
//  PodcastReview
//
//  Created by Tsering Lama on 12/16/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

struct PodcastAPI {
    
    static func getPodcast(userSearch: String, completionHandler: @escaping (Result<[Podcast], AppError>) -> ()) {
        
        let podcastURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(userSearch)"
        var podcasts = [Podcast]()
        
        guard let url = URL(string: podcastURL) else {
            completionHandler(.failure(.badURL(podcastURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completionHandler(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let podcastArr = try JSONDecoder().decode(PodcastData.self, from: data)
                    podcasts = podcastArr.results
                    completionHandler(.success(podcasts))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}
