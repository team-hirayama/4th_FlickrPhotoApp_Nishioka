//
//  FlickrModel.swift
//  FlickrPhotoApp
//
//  Created by NishiokaKohei on 2016/12/17.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import Foundation

class FlickrModel: AnyObject {
    // 共通項
    internal var pages = [Page]()
    internal var photo = [Photo]()
    
}


class Page: FlickrModel {
    
    var perpage: Int = 0
    var page: Int = 0
    var total: Int = 0
    var photos = [Photo]()

}


class Photo: FlickrModel {
    
    var ower = ""
    var farm: Int = 0
    var title = ""
    var isfamily: Int?
    var id: Int = 0
    var server: Int = 0
    var ispublic: Int?
    var secret = ""
    var isfriend: Int?

}
