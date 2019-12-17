//
//  PodcastDetailViewController.swift
//  PodcastReview
//
//  Created by Tsering Lama on 12/16/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

class PodcastDetailViewController: UIViewController {
    
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    var podcast: Podcast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        podcastName.text = podcast.collectionName
        artistName.text = podcast.artistName
        
        podcastImage.getImage(with: podcast.artworkUrl600) { (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self.podcastImage.image = UIImage(systemName: "person.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.podcastImage.image = image
                }
            }
        }
    }
    
    
    
}
