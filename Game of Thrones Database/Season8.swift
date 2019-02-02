//
//  Season8.swift
//  Game of Thrones Database
//
//  Created by Aaron Treinish on 1/28/19.
//  Copyright © 2019 Aaron Treinish. All rights reserved.
//

import Foundation

struct SeasonEight: Codable {
    let episodes: [Episodes]
}

struct Episodes: Codable {
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
