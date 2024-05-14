//
//  Movie.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation

// MARK: - Movie
struct Movies: Codable {
    var page: Int? = 0
    var results: [Movie]? = []
    var totalPages: Int? = 0
    var totalResults: Int? = 0

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let adult: Bool?
    let id: Int?
    let originalTitle: String?
    let posterPath, releaseDate, title: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
