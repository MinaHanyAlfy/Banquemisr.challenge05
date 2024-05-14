//
//  MovieDetailsViewModel.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation
protocol MovieDetailsViewModelProtocol {
    var errorPublisher: Published<ErrorMessage?>.Publisher {get}
    var movieDetailsPublisher: Published<Bool?>.Publisher {get}
    var isLoading: Bool {get set}

    func viewDidLoad()
    func viewDidAppear()
    func fetchMovieDetails()
    func getMovieTitle() -> String
    func getMovieReleaseDate() -> String
    func getMovieRunTimes() -> Int
    func getMovieGenres() -> String
    func getMovieOverview() -> String
    func getMovieImage() -> String
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    @Published private var error: ErrorMessage? = nil
    var errorPublisher: Published<ErrorMessage?>.Publisher {$error}
    
    @Published internal var isMovieFetched: Bool? = nil
    var movieDetailsPublisher: Published<Bool?>.Publisher {$isMovieFetched}
    
    var details: MovieDetails? = nil
    private var movieId: Int = 0
    var isLoading: Bool = false
    private var movieDetailsUseCase: GetMovieDetailsUseCaseProtocol?
    
    func viewDidLoad() {
        //
    }

    func viewDidAppear() {
        fetchMovieDetails()
    }
    
    init(useCase: GetMovieDetailsUseCaseProtocol? = GetMovieDetailsUseCase(), movieId: Int) {
        self.movieDetailsUseCase = useCase
        self.movieId = movieId
    }
    
    func fetchMovieDetails() {
        isLoading = true
        movieDetailsUseCase?.execute(movieId: movieId, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movie):
                self.details = movie
                self.isMovieFetched = true
                self.isLoading = false
            case .failure(let error):
                print(error)
                self.isLoading = false
            }
        })
    }
    
    func getMovieTitle() -> String {
        guard let details = details else { return "" }
        return details.title ?? details.originalTitle ?? ""
    }
    
    func getMovieReleaseDate() -> String {
        guard let details = details else { return "" }
        return details.releaseDate ?? ""
    }
    func getMovieRunTimes() -> Int {
        guard let details = details else { return 0 }
        return details.runtime ?? 0
    }
    
    func getMovieGenres() -> String {
        guard let details = details else { return "" }
        var genres = [String]()
        for genre in details.genres ?? [] {
            genres.append(genre.name ?? "")
        }
            
        return genres.joined(separator: " - ")
    }
    
    func getMovieOverview() -> String {
        guard let details = details else { return "" }
        return details.overview ?? ""
    }
    
    func getMovieImage() -> String {
        guard let details = details else { return "" }
        return details.posterPath ?? ""
    }

}

