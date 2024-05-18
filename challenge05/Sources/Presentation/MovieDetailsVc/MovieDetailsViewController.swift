//
//  MovieDetailsViewController.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import UIKit
import Combine

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rtLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    private var cancellabels = Set<AnyCancellable>()
    private var viewModel: MovieDetailsViewModelProtocol!
    
    public static func ViewController(movieId: Int) -> MovieDetailsViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc = sb.instantiateViewController(identifier: "MovieDetailsViewController", creator: { coder -> MovieDetailsViewController? in
            MovieDetailsViewController(coder: coder)
        })
        vc.viewModel = MovieDetailsViewModel(movieId: movieId)
            return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindData()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    private func viewSetup() {
        genreLabel.text = "Genres: "
        titleLabel.text = "Title: "
        rtLabel.text = "Runtime: "
        releaseLabel.text = "Release Date:"
        overviewLabel.text = "Overview: "
        movieTitleLabel.text = viewModel.getMovieTitle()
        movieOverviewTextView.text = viewModel.getMovieOverview()
        runtimeLabel.text = "\(viewModel.getMovieRunTimes())"
        releaseDateLabel.text = viewModel.getMovieReleaseDate()
        movieImageView.loadImageUsingCacheWithURLString(viewModel.getMovieImage(), placeHolder: UIImage(named: "placeholder"))
        genresLabel.text = viewModel.getMovieGenres()
    }
}

//MARK: - BindData
extension MovieDetailsViewController {
    private func bindData() {
        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                if let error = error {
                    print("Error", error)
                }
            })
            .store(in: &cancellabels)
        
        viewModel.movieDetailsPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] fetched in
                if fetched ?? false{
                    self?.viewSetup()
                }
            })
            .store(in: &cancellabels)
    }
}
