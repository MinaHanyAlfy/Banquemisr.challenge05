//
//  BaseViewController.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import UIKit
import UIKit

internal class BaseViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.registerCell(tableViewCell: MovieTableViewCell.self)
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    lazy var emptyStateView = ZeroStateView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupNavigation()
        setupLoadingIndicatorView()
        setupEmptyStateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 136
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        
    }
    
    private func setupLoadingIndicatorView() {
        view.addSubview(activityIndicatorView)
        
        // Center the activity indicator in the view
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    /// Function to start animating the activity indicator
    internal func startLoading() {
        activityIndicatorView.startAnimating()
        /// For disable user interaction while loading
        view.isUserInteractionEnabled = false
    }
    
    /// Function to stop animating the activity indicator
    internal func stopLoading() {
        activityIndicatorView.stopAnimating()
        /// For re-enable user interaction when loading is complete
        view.isUserInteractionEnabled = true
    }
    /// For Empty view if there's nothing to show 
    private func setupEmptyStateView() {
        emptyStateView.message = "There's no movies right now, Check connection and reopen app."
        tableView.addSubview(emptyStateView)
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            emptyStateView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
        
        updateEmptyStateView()
    }
    
    internal func updateEmptyStateView() {
        let isEmpty = tableView.visibleCells.isEmpty
        emptyStateView.isHidden = !isEmpty
        tableView.separatorStyle = isEmpty ? .none : .singleLine
    }
}

//MARK: - UITableViewDataSource
extension BaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension BaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Movie index:", indexPath.row)
    }
}

//MARK: - UIScrollViewDelegate
extension BaseViewController: UIScrollViewDelegate {
    
}
