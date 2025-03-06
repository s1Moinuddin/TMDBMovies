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
    var filteredPopularMovies: [Movie] = []
    var page: Int = 1
    private var previousPage: Int = 1
    
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
        let endpoint = MovieEndPoint.movieWithCategory(categoryId: categoryId, page: self.page)
        APIClient.shared.objectAPICall(apiEndPoint: endpoint, modelType: MovieResponse.self) { [weak self] (response) in
            switch response {
            case .success(let value):
                SVProgressHUD.dismiss()
                DLog("success \(value.movies.first?.title ?? "N/A")")
                //self?.movies.removeAll()
                self?.movies = value.movies
                self?.fetchPopularMovies(for: categoryId)
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
        guard popularMovies.isEmpty || page != previousPage else {
            filteredPopularMovies = popularMovies.filter({$0.genreIds.contains(categoryId)})
            self.reloadTableView?()
            return
        }
        let endpoint = MovieEndPoint.popularMovieswithCategory(page: self.page)
        APIClient.shared.objectAPICall(apiEndPoint: endpoint, modelType: MovieResponse.self) { [weak self] (response) in
            switch response {
            case .success(let value):
                SVProgressHUD.dismiss()
                DLog("success \(value.movies.first?.title ?? "N/A")")
                self?.previousPage = self?.page ?? 1
                self?.popularMovies = value.movies
                self?.filteredPopularMovies = value.movies.filter({$0.genreIds.contains(categoryId)})
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
