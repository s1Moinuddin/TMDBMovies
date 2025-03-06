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
    
    func getCategories() {
        SVProgressHUD.show()
        let endpoint = MovieEndPoint.categories
        APIClient.shared.objectAPICall(apiEndPoint: endpoint, modelType: MovieCategoryResponse.self) { [weak self] (response) in
            switch response {
            case .success(let value):
                SVProgressHUD.dismiss()
                DLog("success \(value.categories.first?.name ?? "N/A")")
                self?.categories = value.categories
            case .failure((let code, let data, let err)):
                SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                DLog("code = \(code)")
                DLog("data = \(String(describing: data))")
                DLog("error = \(err.localizedDescription)")
            }
        }
        
    }
}
