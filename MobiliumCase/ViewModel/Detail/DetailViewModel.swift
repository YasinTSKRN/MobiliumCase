//
//  DetailViewModel.swift
//  MobiliumCase
//
//  Created by Yasin on 19.03.2020.
//  Copyright © 2020 Yasin. All rights reserved.
//

import Foundation

protocol DetailViewModelProtocol {
    func fetchMovieDetail(movieID: String, completion: (() -> ())?)
    func getCurrentMovie() -> MovieDetail?
}

class DetailViewModel: NSObject, DetailViewModelProtocol {
    
    private lazy var provider = DataProvider()
    private var movieDetail: MovieDetail?
    
    func fetchMovieDetail(movieID: String, completion: (() -> ())?) {
        provider.queryMovieDetail(movieID: movieID) { [unowned self] (result) in
            switch (result) {
            case .success(let detail):
                self.movieDetail = detail
                completion?()
            case .failure(let error):
                print(error)
                completion?()
            }
        }
    }
    
    func getCurrentMovie() -> MovieDetail? {
        return self.movieDetail
    }
}
