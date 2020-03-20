//
//  MovieList.swift
//  MobiliumCase
//
//  Created by Yasin on 18.03.2020.
//  Copyright © 2020 Yasin. All rights reserved.
//

import Foundation

struct MovieList: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let popularity: Double
    let vote_count: Int
    let video: Bool
    let poster_path: String?
    let id: Int
    let adult: Bool
    let backdrop_path: String?
    let original_language: String
    let original_title: String
    let genre_ids: [Int]
    let title: String
    let vote_average: Double
    let overview: String
    let release_date: String
}

enum MovieListResult {
    case success(MovieList)
    case failure(String)
}
