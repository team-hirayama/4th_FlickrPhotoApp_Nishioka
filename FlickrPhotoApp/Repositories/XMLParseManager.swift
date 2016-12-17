//
//  XMLParseManager.swift
//  FlickrPhotoApp
//
//  Created by NishiokaKohei on 2016/12/17.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import SWXMLHash

class XMLParseManager {
    
    class func parseXML(data: AnyObject) -> [Page]? {
        guard let xmlData = data as? NSData else {
            return nil
        }
        
        let xml = SWXMLHash.config { config in
            config.shouldProcessLazily = false
            }.parse(xmlData);
        
        var pages = [Page]()
        
        for page in xml["rsp"]["photos"] {
            let newPage = Page()
            var photos = [Photo]()
            
            if let val = page.element?.attributes["perpage"] {
                newPage.perpage = Int(val)!
            }
            if let val = page.element?.attributes["page"] {
                newPage.page = Int(val)!
            }
            
            for photo in page["photo"] {
                let tempPhoto = Photo()
                if let ower = photo.element?.attributes["ower"] {
                    tempPhoto.ower = ower
                }
                if let farm = photo.element?.attributes["farm"] {
                    tempPhoto.farm = Int(farm)!
                }
                if let title = photo.element?.attributes["title"] {
                    tempPhoto.title = title
                }
                if let isfamily = photo.element?.attributes["isfamily"] {
                    tempPhoto.isfamily = Int(isfamily)!
                }
                if let id = photo.element?.attributes["id"] {
                    tempPhoto.id = Int(id)!
                }
                if let server = photo.element?.attributes["server"] {
                    tempPhoto.server = Int(server)!
                }
                if let ispublic = photo.element?.attributes["ispublic"] {
                    tempPhoto.ispublic = Int(ispublic)!
                }
                if let secret = photo.element?.attributes["secret"] {
                    tempPhoto.secret = secret
                }
                if let isfriend = photo.element?.attributes["isfriend"] {
                    tempPhoto.isfriend = Int(isfriend)!
                }
                photos.append(tempPhoto);
                print(tempPhoto)
            }
            newPage.photos = photos;
            pages.append(newPage);
        }
        return pages
    }
    
    
}


