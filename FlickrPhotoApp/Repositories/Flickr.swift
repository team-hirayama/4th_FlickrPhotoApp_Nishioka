//
//  Flickr.swift
//  FlickrPhotoApp
//
//  Created by NishiokaKohei on 2016/12/17.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct FlickrArguments {
    // https://api.flickr.com/services
    let endpoint = "https://api.flickr.com/services/rest/"
    let method = "method"
    let apiKey = "api_key"
    let text = "text"
    let perPage = "per_page"
    let numberOfPage = "page"
}


class Flickr {
    
    let dir = FlickrArguments()
    // API結果保持用
    var result = [Page]()
    
    // APIリクエスト
    func searchFlickrForTerm(input: String) -> Bool {
        
        Alamofire.request(
            .GET,
            dir.endpoint,
            parameters: [
                dir.method: "flickr.photos.search",
                dir.apiKey: "10ba93bbe49a6480d765ce486673954a",
                dir.text: input,
                dir.perPage: "50",
                dir.perPage:  "2"
            ]).response { (request, data, response, error) in
                
                if let error = error {
                    print(error)
                    return
                }
                
                if let response = response {
                    self.result = XMLParseManager.parseXML(response)!
                }
                
        }
        return true
    }
    
    func searchFlickrWithJSON(input: String) {
        Alamofire.request(.GET,
            dir.endpoint,
            parameters: [
                "method": "flickr.photos.search",
                "key": "10ba93bbe49a6480d765ce486673954a",
                "text": input,
                "perpage": "50",
                "page": "2",
                "format": "json"
            ]).responseJSON { responseData in
                
                guard let data = responseData.result.value else {
                    return
                }
                
                let jasonDATA = JSON(data)
                self.getData(jasonDATA)
                
        }
    }
    
    private func getData(swifyJSON: JSON) {
        guard let object = swifyJSON.array else {
            return
        }
        
        
        print(object)
        
    }

}

extension Flickr {
    
    // APIデータをPhotoで渡すとURLが返す
    class func photoSource(photo: Photo) -> String? {
        return photoSourceURL(photo.farm, id: photo.id, server: photo.server, secret: photo.secret)
    }
    
    // (例) https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
    private class func photoSourceURL( farm: Int, id: Int, server: Int, secret: String) -> String {
        let url = "https://farm\(String(farm))"
            + ".staticflickr.com/\(String(server))"
            + "/\(String(id))"
            + "_\(String(secret))_s.jpg"
        
        return url
    }
    
}

