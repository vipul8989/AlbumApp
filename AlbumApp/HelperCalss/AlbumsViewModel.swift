//
//  AlbumsViewModel.swift
//  AlbumApp
//
//  Created by iMac on 03/06/21.
//

import Foundation

class AlbumsViewModel {
    
    var arrAlbums = [AlbumModel]()
    
    //MARK:- Fetch data from server
    func fetchData(completion: @escaping (_ status: Bool) -> Void) {
        
        ServiceManager.getRequest(url: API_URL) { (dict, status) in
            
            // check for success
            if status {
                
                if let feed = dict["feed"] as? NSDictionary, let results = feed["results"] as? NSArray {
                    
                    print(feed)
                    do {
                        // JSON object to Data conversion
                        let data = try JSONSerialization.data(withJSONObject: results, options: .prettyPrinted)
                        let result = try JSONDecoder().decode([AlbumModel].self, from: data)
                        self.arrAlbums = result
                        completion(true)
                    } catch {
                        print(error)
                        completion(false)
                    }
                }
            }
        }
    }
}
