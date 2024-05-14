//
//  PopulerViewController.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import UIKit
import Combine

class PopulerViewController: BaseViewController {
    
    private var cancellabels = Set<AnyCancellable>()
    var viewModel: PopulerViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Populer"
        viewModel = PopulerViewModel()
        viewModel.viewDidLoad()
        bindData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
    
}

//MARK: - UITableViewDataSource
extension PopulerViewController {
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

//MARK: - Data Binding
extension PopulerViewController {
    private func bindData() {
        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                if let error = error {
                    print("Error", error)
                }
            })
            .store(in: &cancellabels)
        
        viewModel.moviesPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] fetched in
                if fetched ?? false {
                        self?.tableView.reloadData()
                }
            })
            .store(in: &cancellabels)
    }
    
}

//MARK: - UIScrollViewDelegate
extension PopulerViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height {
            if !viewModel.isLoading {
                // Load more data
                viewModel.fetchMovies()
            }
        }
    }
}
