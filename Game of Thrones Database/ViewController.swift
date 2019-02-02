//
//  ViewController.swift
//  Game of Thrones Database
//
//  Created by Aaron Treinish on 12/11/18.
//  Copyright © 2018 Aaron Treinish. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var characterArray: [Characters] = []
    var filteredCharacterArray = [Characters]()
    
    var baseURL = URL(string: "https://api.got.show/api/")
    
    var url = URL(string: "https://api.got.show/api/characters/")!
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self

      
        
        //fetchCharacterData()
        
        setUpNavBar()
        
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = (self as! UISearchResultsUpdating)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Characters"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        parseData()
        
    }

//    func fetchCharacterData() {
//        DispatchQueue.main.async {
//            Alamofire.request(self.url).responseJSON(completionHandler: {(response) in
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//
//                    if let names = json[0]["name"].array {
//                        for name in names {
//                            if let name = name[0]["name"].string {
//                                print(name)
//                            }
//                        }
//                    }
//
////                    for (_, name) in names {
////                        print(name["name"])
////                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            })
//        }
//    }
    
    func setUpNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCharacterArray = characterArray.filter({ results -> Bool in
            results.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }


    
    func parseData() {

        //fetch data
        URLSession.shared.dataTask(with: url) {(data, response, error) in

            //to avoid non optional in JSONDecoder
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                //decode object
                let downloadedData = try decoder.decode([Characters].self, from: data)
//                print(downloadedData)
                var characterData = downloadedData
                DispatchQueue.main.async {
                    self.characterArray.append(contentsOf: characterData)
                    self.tableView.reloadData()
                   // print(self.arrayDownloadedData)
                    self.filteredCharacterArray = self.characterArray
                }

            } catch {
                print(error)

            }

            }.resume()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCharacterArray.count
        }
        return characterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CharacterTableViewCell else { return UITableViewCell() }
        
        let characters: Characters
        if isFiltering() {
            characters = filteredCharacterArray[indexPath.row]
        } else {
            characters = characterArray[indexPath.row]
        }
        
       // let defaultHouseLabel = String("No House")
        
        cell.nameLabel.text = "Character: " + characters.name
        cell.houseLabel.text = "House: " + (characters.house ?? "No House")
        cell.booksLabel.text = "Books: " + characters.books.joined(separator: ", ")

       // let url = URL(string: "https://example.com/high_resolution_image.png")
       
        //let url = URL(string: "https://api.got.show/\(imageURL)")
        //cell.characterImage.sd_setImage(with: URL(string: "httpS://api.got.show/\(imageURL)"), placeholderImage: UIImage(named: "defaultRickAndMortyImage"))
        
        //let url = URL(string: "https://api.got.show/\(characters.imageLink!)")
        //cell.characterImage.kf.setImage(with: imageURL)
    
        
        
        let size = cell.characterImage.frame.size
        let processor = DownsamplingImageProcessor(size: size)
            >> RoundCornerImageProcessor(cornerRadius: 20)
        //let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: self.flickrPhoto.frame.size.width * UIScreen.main.scale, height: self.flickrPhoto.frame.size.height * UIScreen.main.scale))
        cell.characterImage.kf.indicatorType = .activity
        let imageURL = URL(string: "https://api.got.show/\( characters.imageLink ?? "No image")")
        cell.characterImage.kf.setImage(
            with: imageURL,
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let currentImage = characterArray[indexPath.row].imageLink
//        let imageCrop = currentImage.getCropRatio()
//    }
    

}

extension ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
        
    }
}

extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}


