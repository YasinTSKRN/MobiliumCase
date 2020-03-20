//
//  DiscoverViewController.swift
//  MobiliumCase
//
//  Created by Yasin on 19.03.2020.
//  Copyright © 2020 Yasin. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher

class DiscoverViewController: UIViewController {
    
    private var viewModel: DiscoverProtocol!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "PagerCell")
        }
    }
    @IBOutlet weak var upcomingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = DiscoverViewModel()
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
        self.upcomingTableView.delegate = self
        self.upcomingTableView.dataSource = self
        self.viewModel.fetchUpcoming { [unowned self] in
            self.upcomingTableView.reloadData()
        }
        self.viewModel.updateNowPlaying { [unowned self] in
            self.pagerView.reloadData()
        }
    }
    
    func openDetail(movieID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.movieID = movieID
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

extension DiscoverViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.viewModel.numberOfNowPlaying()
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let movie = self.viewModel.nowPlayingAtIndex(atIndex: index)
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PagerCell", at: index)
        cell.imageView?.kf.setImage(with: PictureUtils.createPictureURL(path: movie.backdrop_path))
        cell.textLabel?.text = movie.title
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        self.openDetail(movieID: String(self.viewModel.nowPlayingAtIndex(atIndex: index).id))
    }
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfUpcoming()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingCell", for: indexPath) as? UpcomingCell {
            let movie = self.viewModel.upcomingAtIndex(atIndex: indexPath.row)
            //cell.moviePoster.image = UIImage(systemName: "square.stack.3d.down.dottedline") ?? UIImage()
            cell.configureCell(movie: movie)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openDetail(movieID: String(self.viewModel.upcomingAtIndex(atIndex: indexPath.row).id))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.numberOfUpcoming() - 2 && self.viewModel.hasMoreUpcomingData() {
            self.viewModel.fetchUpcoming() { [unowned self] in
                self.upcomingTableView.reloadData()
            }
        }
    }
}
