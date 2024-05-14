//
//  MoviesRouter.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation

enum MoviesRouter: EndPoint {
    case getUpcomingMovies(page: Int)
    case getPopulerMovies(page: Int)
    case getPlayingMovies(page: Int)
    case getMovieDetails(movieId: Int)
    
    var baseURL: String {
        switch self {
        case .getUpcomingMovies, .getPlayingMovies, .getPopulerMovies, .getMovieDetails:
            return "https://api.themoviedb.org"
        
        }
        
    }
    var urlSubFolder: String {
        switch self {
        case .getUpcomingMovies:
            return "/3/movie/popular"
        case .getPopulerMovies:
            return "/3/movie/upcoming"
        case .getPlayingMovies:
            return "/3/movie/now_playing"
        case .getMovieDetails(let id):
            return "/3/movie/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .getPlayingMovies(let page):
            return [URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "language", value: "en-US")
                   ]
        case .getPopulerMovies(let page):
            return [URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "language", value: "en-US")
                   ]
        case .getUpcomingMovies(let page):
            return [URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "language", value: "en-US")
                   ]
        case .getMovieDetails:
            return [URLQueryItem(name: "language", value: "en-US")]
      
        }
    }
}

