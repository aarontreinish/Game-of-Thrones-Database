//
//  Episodes.swift
//  Game of Thrones Database
//
//  Created by Aaron Treinish on 1/10/19.
//  Copyright © 2019 Aaron Treinish. All rights reserved.
//

import Foundation

struct Seasons: Codable {
   // let id, air_date: String
    let episodes: [Episode]
}

struct Episode: Codable {
    let air_date: String?
    let episode_number: Int?
   // let id: Int
    let name, overview: String?
    let production_code: String?
    let season_number, show_id: Int?
    let still_path: String?
    let vote_average: Double?
    let vote_count: Int?
//    let crew: [Crew]
//    let guest_stars: [GuestStar]
   
}

//struct Crew: Codable {
//   // let id: Int
//    let credit_id, name, department, job: String
//    let gender: Int
//    let profile_path: String
//
//}
//
//struct GuestStar: Codable {
//   // let id: Int
//    let name, credit_id, character: String
//    let order, gender: Int
//    let profile_path: String
//
//}

//
//struct Seasons : Codable {
//
//   // let id : String?
//    let airDate : String?
//    let episodes : [Episode]
//    //let id : Int?
//    let name : String?
//    let overview : String?
//    let posterPath : String?
//    let seasonNumber : Int?
//
//}
//
//struct Episode : Codable {
//
//    let airDate : String?
//    let crew : [Crew]?
//    let episodeNumber : Int?
//    let guestStars : [GuestStar]?
//    //let id : Int?
//    let name : String?
//    let overview : String?
//    let productionCode : String?
//    let seasonNumber : Int?
//    let showId : Int?
//    let stillPath : String?
//    let voteAverage : Float?
//    let voteCount : Int?
//}
//
//struct Crew : Codable {
//
//    let creditId : String?
//    let department : String?
//    let gender : Int?
//    //let id : Int?
//    let job : String?
//    let name : String?
//    let profilePath : String?
//}
//
//struct GuestStar : Codable {
//
//    let character : String?
//    let creditId : String?
//    let gender : Int?
//    //let id : Int?
//    let name : String?
//    let order : Int?
//    let profilePath : String?
//}
