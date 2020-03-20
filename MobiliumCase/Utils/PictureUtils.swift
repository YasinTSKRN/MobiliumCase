//
//  PictureUtils.swift
//  MobiliumCase
//
//  Created by Yasin on 20.03.2020.
//  Copyright © 2020 Yasin. All rights reserved.
//

import Foundation

private let baseURL = "https://image.tmdb.org/t/p"
private let pictureWidth = "/w500"

class PictureUtils: NSObject {
    static func createPictureURL(path: String?) -> URL? {
        if let path = path {
            return URL(string: (baseURL + pictureWidth + path))
        }
        return URL(string: "https://omegamma.com.au/wp-content/uploads/2017/04/default-image.jpg")
    }
}
