//
//  AlbumAppTests.swift
//  AlbumAppTests
//
//  Created by iMac on 02/06/21.
//

import XCTest
@testable import AlbumApp

class AlbumAppTests: XCTestCase {

    let albumsViewModel = AlbumsViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApiResponse() throws {
        
        // for test api response
        let URL = NSURL(string: API_URL)!
        let exp = self.expectation(description: "GET \(URL)")
        
        let session = URLSession.shared
        let task = session.dataTask(with: URL as URL) { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let HTTPResponse = response as? HTTPURLResponse,
               let responseURL = HTTPResponse.url
            {
                XCTAssertEqual(responseURL.absoluteString, URL.absoluteString, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            
            exp.fulfill()
        }
        
        task.resume()
        
        waitForExpectations(timeout: task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
    
    func testAlbums() throws {

        let URL = NSURL(string: API_URL)!
        let exp = self.expectation(description: "GET \(URL)")
        
        let session = URLSession.shared
        let task = session.dataTask(with: URL as URL) { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                XCTAssertNotNil(jsonResult, "response not in json object")
                
                let feed = jsonResult!["feed"] as? NSDictionary
                XCTAssertNotNil(feed, "feed should not be nil")

                let results = feed!["results"] as? NSArray
                XCTAssertNotNil(results, "results should not be nil")

                let data = try JSONSerialization.data(withJSONObject: results as Any, options: .prettyPrinted)
                XCTAssertNotNil(data, "results not converted in data")

                let result = try JSONDecoder().decode([AlbumModel].self, from: data)
                XCTAssertNotNil(result, "model conversion failed")

            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
            }
            
            exp.fulfill()
        }
        
        task.resume()
        
        waitForExpectations(timeout: task.originalRequest!.timeoutInterval) { error in
            task.cancel()
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
