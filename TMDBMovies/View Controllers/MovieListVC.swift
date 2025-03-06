//
//  ViewController.swift
//  TMDBMovies
//
//  Created by S.M.Moinuddin on 6/3/25.
//

import UIKit
import SVProgressHUD

class MovieListVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = "Movies"
        self.view.backgroundColor = .purple.withAlphaComponent(0.7)
        self.tableView.backgroundColor = .black.withAlphaComponent(0.8)
        
        
    }


}

