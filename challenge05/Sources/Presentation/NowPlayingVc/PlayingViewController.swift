//
//  PlayingViewController.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import UIKit
import Combine

class PlayingViewController: BaseViewController {
    private var cancellabels = Set<AnyCancellable>()
    var viewModel: PlayingViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Now Playing"
        
        startLoading()
        viewModel = PlayingViewModel()
        viewModel.viewDidLoad()
        bindData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
}

//MARK: - UITableViewDataSource
extension PlayingViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(tableViewCell: MovieTableViewCell.self, forIndexPath: indexPath)
        let movie = viewModel.getMovie(index: indexPath.row)
        cell.setupCell(movie: movie)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension PlayingViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.getMovie(index: indexPath.row)
        let vc = MovieDetailsViewController.ViewController(movieId: movie.id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Data Binding
extension PlayingViewController {
    private func bindData() {
        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                if let error = error {
                    print("Error", error)
                    self?.stopLoading()
                }
            })
            .store(in: &cancellabels)
        
        viewModel.moviesPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] fetched in
                if fetched ?? false {
                    self?.stopLoading()
                    self?.tableView.reloadData()
                    self?.updateEmptyStateView()

                }
            })
            .store(in: &cancellabels)
    }
}

//MARK: - UIScrollViewDelegate
extension PlayingViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height {
            if !viewModel.isLoading {
                // Load more data
                startLoading()
                viewModel.fetchMovies()
            }
        }
    }
}
