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
    
    static func postFavorite(favorite: PostFavorite, completionHandler: @escaping (Result<Bool,AppError>)->()) {
        
        let postURL = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: postURL) else {
            completionHandler(.failure(.badURL(postURL)))
            return
        }
        
        do {
            let data = try JSONEncoder().encode(favorite)
            var request = URLRequest(url: url)
            request.httpBody = data
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completionHandler(.failure(.networkClientError(appError)))
                case .success:
                    completionHandler(.success(true))
                }
            }
        } catch {
            completionHandler(.failure(.encodingError(error)))
        }
    }
    
    static func getFavorites(completionHandler: @escaping (Result<[PostFavorite],AppError>)->()) {
        
        let getURL = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: getURL) else {
            completionHandler(.failure(.badURL(getURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completionHandler(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let favorties = try JSONDecoder().decode([PostFavorite].self, from: data)
                    completionHandler(.success(favorties))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}
