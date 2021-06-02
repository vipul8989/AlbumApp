//
//  AlbumModel.swift
//  AlbumApp
//
//  Created by iMac on 03/06/21.
//

import UIKit
import Foundation

//MARK:- AlbumModel structure
struct AlbumModel: Codable {
    var artistId: String?
    var artistName: String?
    var artistUrl: String?
    var artworkUrl100: String?
    var contentAdvisoryRating: String?
    var copyright: String?
    var id: String?
    var kind: String?
    var name: String?
    var releaseDate: String?
    var url: String?
    var genres: [GenreModel]?
}

//MARK:- GenreModel structure
struct GenreModel: Codable {
    var genreId: String?
    var name: String?
    var url: String?
}

//MARK:- Extension
extension UIImageView {
    
    func downloadImage(link: String, placeholder: String) {
        
        if let cachedImage = imageCache.object(forKey: link as NSString) {
            self.image = cachedImage
        } else {
            
            if URL.init(string: link) != nil {
                URLSession.shared.dataTask(with: URL.init(string: link)!) { (data, response, error) in
                    
                    DispatchQueue.main.async {
                        if error != nil {
                            self.image = UIImage.init(named: placeholder)
                        } else if let data = data, let image = UIImage(data: data) {
                            imageCache.setObject(image, forKey: link as NSString)
                            self.image = UIImage(data: data)
                        } else {
                            self.image = UIImage.init(named: placeholder)
                        }
                    }
                }.resume()
            } else {
                self.image = UIImage.init(named: placeholder)
            }
        }
    }
}

