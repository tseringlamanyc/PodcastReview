//
//  FavoriteViewController.swift
//  PodcastReview
//
//  Created by Tsering Lama on 12/16/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var podcast: Podcast!
    
    var favorite = [PostFavorite]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadFavorite()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         guard let podcastVC = segue.destination as? PodcastDetailViewController, let indexpath = tableView.indexPathForSelectedRow else {
//             fatalError()
//         }
//         podcastVC.podcast =
//     }
    
    func loadFavorite() {
        PodcastAPI.getFavorites { (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self.showAlert(title: "No favorite found", message: "\(appError)")
                }
            case .success(let favorite):
                DispatchQueue.main.async {
                    self.favorite = favorite.filter {$0.favoritedBy == "Tsering"}
                }
            }
        }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        let aFavorite = favorite[indexPath.row]
        cell.textLabel?.text = aFavorite.collectionName
        return cell
    }
    
    
}
