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
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
        
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .black.withAlphaComponent(0.8)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.reuseIdentifier)
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.reuseIdentifierPopular)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                        action: #selector(pulldown), for: .valueChanged)
        tableView.refreshControl?.tintColor = .white
        // to fix glitch of refresh control while using prefersLargeTitles to true
        // table view top contraint with spuerView 
        tableView.contentInsetAdjustmentBehavior = .always
    }
    
    @objc func pulldown() {
        viewModel.page = viewModel.page == 2 ? 1 : 2
        viewModel.getCategories()
    }
    
    // Table view data source methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getTableCellCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath) as! CategoryTableViewCell
            cell.configure(with: viewModel.categories, selectedCategory: viewModel.selectedCategory)
            cell.categorySelected = { [weak self] selectedCategory in
                DLog("selected category Id = \(selectedCategory.id), name = \(selectedCategory.name)")
                self?.viewModel.selectedCategory = selectedCategory
                self?.viewModel.fetchMovies(for: selectedCategory.id)
            }
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reuseIdentifier, for: indexPath) as! MoviesTableViewCell
            cell.configure(with: viewModel.movies, reuseIdentifier: PosterCollectionViewCell.reuseIdentifier)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reuseIdentifierPopular, for: indexPath) as! MoviesTableViewCell
            cell.configure(with: viewModel.filteredPopularMovies, reuseIdentifier: PosterCollectionViewCell.reuseIdentifierPopular)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 2){
            return 40
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
                    
                    let label = UILabel()
                    label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
                    label.text = "Most Popular"
            label.font = .systemFont(ofSize: 17, weight: .medium)
            label.textColor = .white
                    
                    headerView.addSubview(label)
                    
                    return headerView
        }
        return UIView()
    }
    
}

