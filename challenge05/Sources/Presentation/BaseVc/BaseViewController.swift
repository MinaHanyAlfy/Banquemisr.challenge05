//
//  BaseViewController.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import UIKit
import UIKit

class BaseViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupNavigation()
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
