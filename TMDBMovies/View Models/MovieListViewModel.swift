//
//  MovieListViewModel.swift
//  TMDBMovies
//
//  Created by S.M.Moinuddin on 6/3/25.
//

import Foundation
import SVProgressHUD

class MovieListViewModel {
    var categories: [MovieCategory] = []
    var selectedCategory: MovieCategory?
    var movies: [Movie] = []
    var popularMovies: [Movie] = []
    
    var reloadTableView: (() -> Void)?
    
    func getTableCellCount() -> Int {
        if(categories.count > 0 && movies.count > 0 && popularMovies.count > 0) {
            return 3
        }else if(categories.count > 0 && movies.count > 0) {
            return 2
        }else if(categories.count > 0) {
            return 1
        }else {
            return 0
        }
    }
    
    func getCategories() {
        SVProgressHUD.show()
        let endpoint = MovieEndPoint.categories
        APIClient.shared.objectAPICall(apiEndPoint: endpoint, modelType: MovieCategoryResponse.self) { [weak self] (response) in
            switch response {
            case .success(let value):
                SVProgressHUD.dismiss()
                DLog("success \(value.categories.first?.name ?? "N/A")")
                self?.categories = value.categories
                self?.selectedCategory = self?.categories.first
                self?.fetchMovies(for: self?.selectedCategory?.id)
                
            case .failure((let code, let data, let err)):
                SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                DLog("code = \(code)")
                DLog("data = \(String(describing: data))")
                DLog("error = \(err.localizedDescription)")
            }
        }
    }
    
    func fetchMovies(for categoryId: Int?) {
        if(!SVProgressHUD.isVisible()) {
            SVProgressHUD.show()
        }
        guard let categoryId = categoryId else {
            SVProgressHUD.dismiss()
            return
        }
        let endpoint = MovieEndPoint.movieWithCategory(categoryId: categoryId, page: 1)
        APIClient.shared.objectAPICall(apiEndPoint: endpoint, modelType: MovieResponse.self) { [weak self] (response) in
            switch response {
            case .success(let value):
                SVProgressHUD.dismiss()
                DLog("success \(value.movies.first?.title ?? "N/A")")
                self?.movies.removeAll()
                self?.movies = value.movies
                self?.reloadTableView?()
                //self?.fetchPopularMovies(for: categoryId)
            case .failure((let code, let data, let err)):
                SVProgressHUD.dismiss()
                self?.reloadTableView?() //show categories if any
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                DLog("code = \(code)")
                DLog("data = \(String(describing: data))")
                DLog("error = \(err.localizedDescription)")
            }
        }
    }
    
    func fetchPopularMovies(for categoryId: Int?) {
        guard let categoryId = categoryId else {
            SVProgressHUD.dismiss()
            self.reloadTableView?()
            return
        }
        let endpoint = MovieEndPoint.popularMovieswithCategory(categoryId: categoryId, page: 1)
        APIClient.shared.objectAPICall(apiEndPoint: endpoint, modelType: MovieResponse.self) { [weak self] (response) in
            switch response {
            case .success(let value):
                SVProgressHUD.dismiss()
                DLog("success \(value.movies.first?.title ?? "N/A")")
                self?.movies = value.movies
                self?.reloadTableView?()
            case .failure((let code, let data, let err)):
                SVProgressHUD.dismiss()
                self?.reloadTableView?() //show categories and movies if any
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                DLog("code = \(code)")
                DLog("data = \(String(describing: data))")
                DLog("error = \(err.localizedDescription)")
            }
        }
        
    }
    
}
