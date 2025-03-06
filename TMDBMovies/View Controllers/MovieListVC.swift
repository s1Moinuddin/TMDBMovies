//
//  ViewController.swift
//  TMDBMovies
//
//  Created by S.M.Moinuddin on 6/3/25.
//

import UIKit
import SVProgressHUD

class MovieListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = "Movies"
        self.navigationItem.largeTitleDisplayMode = .always
        self.view.backgroundColor = .purple.withAlphaComponent(0.7)
        
        setupTableView()
        
        viewModel.getCategories()
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .black.withAlphaComponent(0.8)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
    }
    
    // Table view data source methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categories.count > 1 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath) as! CategoryTableViewCell
            cell.configure(with: viewModel.categories, selectedCategory: viewModel.selectedCategory)
            cell.categorySelected = { [weak self] selectedCategory in
                self?.viewModel.selectedCategory = selectedCategory
                self?.viewModel.fetchMovies(for: selectedCategory.id)
            }
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    
}

