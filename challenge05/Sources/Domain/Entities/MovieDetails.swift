//
//  MovieDetails.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation

// MARK: - MovieDetails
struct MovieDetails: Codable {
    var adult: Bool?
    var budget: Int?
    var genres: [Genre]?
    var id: Int?
    var imdbID: String?
    var originalLanguage, originalTitle, overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var revenue, runtime: Int?
    var status, tagline, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case budget, genres, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name: String?
}
