//
//  DetailViewController.swift
//  MobiliumCase
//
//  Created by Yasin on 20.03.2020.
//  Copyright © 2020 Yasin. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var movieID: String!
    private var viewModel: DetailViewModelProtocol!

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var infoText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = DetailViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let movieID = self.movieID {
            self.viewModel.fetchMovieDetail(movieID: movieID) { [unowned self] in
                if let movie = self.viewModel.getCurrentMovie() {
                    self.posterImage.kf.setImage(with: PictureUtils.createPictureURL(path: movie.backdrop_path))
                    self.titleLabel.text = movie.title
                    self.ratingLabel.text = String(movie.vote_average)
                    self.infoText.text = movie.overview
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
