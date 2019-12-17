//
//  ViewController.swift
//  PodcastReview
//
//  Created by Tsering Lama on 12/16/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {
    
    @IBOutlet weak var podcastSearch: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var currentPodcast = ""
    
    func searchPodcast(userPodcast: String) {
        currentPodcast = userPodcast
        PodcastAPI.getPodcast(userSearch: userPodcast) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let podcast):
                self?.podcasts = podcast
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        podcastSearch.delegate = self
        searchPodcast(userPodcast: currentPodcast)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let podcastVC = segue.destination as? PodcastDetailViewController, let indexpath = tableView.indexPathForSelectedRow else {
            fatalError()
        }
        podcastVC.podcast = podcasts[indexpath.row]
    }
}

extension PodcastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? CustomTableViewCell else {
            fatalError()
        }
        let aPodcast = podcasts[indexPath.row]
        cell.updateCell(podcast: aPodcast)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension PodcastViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else {
            print("error")
            return
        }
        searchPodcast(userPodcast: searchText)
    }
}

