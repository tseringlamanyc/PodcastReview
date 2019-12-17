//
//  CustomTableViewCell.swift
//  PodcastReview
//
//  Created by Tsering Lama on 12/16/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var podcastImage: UIImageView!
    func updateCell(podcast: Podcast) {
        
        podcastImage.getImage(with: podcast.artworkUrl600) { [weak self](result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self?.podcastImage.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImage.image = image
                }
            }
        }
    }
}
