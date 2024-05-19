//
//  ComingViewController.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import UIKit
import Combine

class ComingViewController: BaseViewController {
    private var cancellabels = Set<AnyCancellable>()
    private var viewModel: ComingViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Up Coming"
        
        startLoading()
        viewModel = ComingViewModel()
        viewModel.viewDidLoad()
        bindData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
    
}

//MARK: - UITableViewDataSource
extension ComingViewController {
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
extension ComingViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.isReachable() {
            let movie = viewModel.getMovie(index: indexPath.row)
            let vc = MovieDetailsViewController.ViewController(movieId: movie.id ?? 0)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            self.alertView(message: ErrorMessage.NoInternet.rawValue)
        }
    }
}

//MARK: - Data Binding
extension ComingViewController {
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
extension ComingViewController {
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height {
            if !viewModel.isLoading {
                // Load more data
                if viewModel.isReachable() {
                    startLoading()
                    viewModel.fetchMovies()
                }
            }
        }
    }
}
