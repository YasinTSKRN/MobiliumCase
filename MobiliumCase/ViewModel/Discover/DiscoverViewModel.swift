//
//  DiscoverViewModel.swift
//  MobiliumCase
//
//  Created by Yasin on 18.03.2020.
//  Copyright © 2020 Yasin. All rights reserved.
//

import Foundation

protocol DiscoverProtocol {
    func updateNowPlaying(completion: (() -> ())?)
    func numberOfNowPlaying() -> Int
    func nowPlayingAtIndex(atIndex: Int) -> Movie
    func fetchUpcoming(completion: (() -> ())?)
    func hasMoreUpcomingData() -> Bool
    func numberOfUpcoming() -> Int
    func upcomingAtIndex(atIndex: Int) -> Movie
}

class DiscoverViewModel: NSObject, DiscoverProtocol {
    
    private lazy var provider = DataProvider()
    private var nowPlayingMovies: [Movie] = []
    private var upcomingMovies: [Movie] = []
    private var upcomingCurrentPage = 0
    private var upcomingTotalPage = 0
    
    func updateNowPlaying(completion: (() -> ())?) {
        provider.fetchNowPlaying { [unowned self] (result) in
            switch (result) {
            case .success(let movies):
                self.nowPlayingMovies.append(contentsOf: movies.results)
                completion?()
            case .failure(let error):
                print(error)
                completion?()
            }
        }
    }
    
    func numberOfNowPlaying() -> Int {
        return self.nowPlayingMovies.count
    }
    
    func nowPlayingAtIndex(atIndex: Int) -> Movie {
        return self.nowPlayingMovies[atIndex]
    }
    
    func hasMoreUpcomingData() -> Bool {
        if self.upcomingCurrentPage == self.upcomingTotalPage && self.upcomingCurrentPage != 0 {
            return false
        }
        return true
    }
    
    func fetchUpcoming(completion: (() -> ())?) {
        provider.fetchUpcoming(page: self.upcomingCurrentPage + 1) { [unowned self] (result) in
            switch (result) {
            case .success(let movies):
                self.upcomingMovies.append(contentsOf: movies.results)
                self.upcomingCurrentPage = movies.page
                self.upcomingTotalPage = movies.total_pages
                completion?()
            case .failure(let error):
                print(error)
                completion?()
            }
        }
    }
    
    func numberOfUpcoming() -> Int {
        return self.upcomingMovies.count
    }
    
    func upcomingAtIndex(atIndex: Int) -> Movie {
        return self.upcomingMovies[atIndex]
    }
}
