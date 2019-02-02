//
//  Characters.swift
//  Game of Thrones Database
//
//  Created by Aaron Treinish on 12/11/18.
//  Copyright © 2018 Aaron Treinish. All rights reserved.
//

import Foundation

struct Characters: Codable {
//    let _id: String
//    let male: Bool
//    let house: String
//    let slug: String
    let name: String
    let house: String?
    //let dateOfBirth: String?
    let imageLink: String?
//    let _v: Int
//    let pageRank: Double
    let books: [String]
//       let updatedAt: String
//    let createdAt: String
//    let titles: [String]
}
