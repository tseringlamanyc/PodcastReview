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
    @IBOutlet weak var trackID: UILabel!
    
    var podcast: Podcast!
    
    var favoritedByMe = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        podcastName.text = podcast.collectionName
        artistName.text = podcast.artistName
        trackID.text = "Track:\(podcast.trackId.description)"
        
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
    
    
    
    @IBAction func favoritePressed(_ sender: UIBarButtonItem) {
        
        _ = favoritedByMe
        let artworkUrl600 = podcast.artworkUrl600
        guard let trackID = trackID.text, let collectionName = podcastName.text
            else {
                return
        }
        
        let favorited = PostFavorite.init(trackId: Int(trackID) ?? 0, favoritedBy: "Tsering", collectionName: collectionName, artworkUrl600: artworkUrl600)
        
        PodcastAPI.postFavorite(favorite: favorited) { (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    self.showAlert(title: "Failed", message: "\(appError)")
                }
            case .success:
                DispatchQueue.main.async {
                    self.showAlert(title: "Success", message: "Thanks") {alert in self.dismiss(animated: true)}
                }
            }
        }
    }
}
