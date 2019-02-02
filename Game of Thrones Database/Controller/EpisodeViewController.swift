//
//  EpisodeViewController.swift
//  Game of Thrones Database
//
//  Created by Aaron Treinish on 1/10/19.
//  Copyright © 2019 Aaron Treinish. All rights reserved.
//

import UIKit
import Kingfisher

class EpisodeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
 
    
    @IBOutlet weak var seasonsCollectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    var episodeArray = [Episode]()
    var sortedEpisodeArray = [Episode]()
    var filteredEpisodeArray = [Episode]()
    var url = URL(string: "https://api.themoviedb.org/3/tv/1399/season/1?api_key=1e1015160ca5ff95a08d0806061f49a4")!
    var season1Url = URL(string: "https://api.themoviedb.org/3/tv/1399/season/1?api_key=1e1015160ca5ff95a08d0806061f49a4")!
    var season2Url = URL(string: "https://api.themoviedb.org/3/tv/1399/season/2?api_key=1e1015160ca5ff95a08d0806061f49a4")!
    var season3Url = URL(string: "https://api.themoviedb.org/3/tv/1399/season/3?api_key=1e1015160ca5ff95a08d0806061f49a4")!
    var season4Url = URL(string: "https://api.themoviedb.org/3/tv/1399/season/4?api_key=1e1015160ca5ff95a08d0806061f49a4")!
    var season5Url = URL(string: "https://api.themoviedb.org/3/tv/1399/season/5?api_key=1e1015160ca5ff95a08d0806061f49a4")!
    var season6Url = URL(string: "https://api.themoviedb.org/3/tv/1399/season/6?api_key=1e1015160ca5ff95a08d0806061f49a4")!
    var season7Url = URL(string: "https://api.themoviedb.org/3/tv/1399/season/7?api_key=1e1015160ca5ff95a08d0806061f49a4")!
    var season8Url = URL(string: "https://api.themoviedb.org/3/tv/1399/season/8?api_key=1e1015160ca5ff95a08d0806061f49a4")!
    //api image url
    var imageApiURL = URL(string: "https://image.tmdb.org/t/p/w500")!
    var seasonsArray = ["1", "2", "3", "4", "5", "6", "7"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        parseData()
        setUpNavBar()
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.seasonsCollectionView.delegate = self
        self.seasonsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
 
    func setUpNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //Parse JSON from the Movie Database API
    func parseData() {
        
        //fetch data
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            //to avoid non optional in JSONDecoder
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                //decode object
                let downloadedData = try decoder.decode(Seasons.self, from: data)
                //print(downloadedData)
               
                self.episodeArray.append(contentsOf: downloadedData.episodes)
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    self.filteredEpisodeArray = self.episodeArray
                }
                
            } catch {
                print(error)
                
            }
            
            }.resume()
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell") as? EpisodeTableViewCell else { return UITableViewCell() }
        
     
        //configure tableview
        let episodes: Episode
        episodes = episodeArray[indexPath.row]
        
        cell.nameLabel.text = "Title: " + episodes.name!
        cell.overviewLabel.text = "Overview: " + episodes.overview!
        cell.episodeNumberLabel.text = "Episode: " + String(episodes.episode_number!)
        cell.airDateLabel.text = "Air Date: " + episodes.air_date!
        
        
        let size = cell.episodeImageView.frame.size
        let processor = DownsamplingImageProcessor(size: size)
            >> RoundCornerImageProcessor(cornerRadius: 20)
        cell.episodeImageView.kf.indicatorType = .activity
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(episodes.still_path!)")
        cell.episodeImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "defaultRickAndMortyImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasonsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = seasonsCollectionView.dequeueReusableCell(withReuseIdentifier: "seasonCell", for: indexPath) as! SeasonsCollectionViewCell
        
        cell.seasonsLabel.text = seasonsArray[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)as! SeasonsCollectionViewCell
        
        //configure collectionView
        cell.backgroundColor = UIColor.gray
        
        var index = collectionView.indexPath(for: cell)
        
        print(index)
        
        //pick which season you want to view and shows corresponding data
        if index == [0, 0] {
            url = season1Url
            episodeArray.removeAll()
            parseData()
            tableView.reloadData()
        }
        else {
            
        }
        
        if index == [0, 1] {
            url = season2Url
            episodeArray.removeAll()
            parseData()
            tableView.reloadData()
        }
        else {
            
        }
        
        if index == [0, 2] {
            url = season3Url
            episodeArray.removeAll()
            parseData()
            tableView.reloadData()
        }
        else {
            
        }
        
        if index == [0, 3] {
            url = season4Url
            episodeArray.removeAll()
            parseData()
            tableView.reloadData()
        }
        else {
            
        }
        
        if index == [0, 4] {
            url = season5Url
            episodeArray.removeAll()
            parseData()
            tableView.reloadData()
        }
        else {
            
        }
        
        if index == [0, 5] {
            url = season6Url
            episodeArray.removeAll()
            parseData()
            tableView.reloadData()
        }
        else {
            
        }
        
        if index == [0, 6] {
            url = season7Url
            episodeArray.removeAll()
            parseData()
            tableView.reloadData()
        }
        else {
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // Un selected a cell
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
    }

}
