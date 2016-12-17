//
//  FlickrView.swift
//  FlickrPhotoApp
//
//  Created by NishiokaKohei on 2016/12/17.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import UIKit

class FlickrView: UIView {
    
    let seaechIcon: UISearchBarIcon = .Clear
    let keyword: String = "キーワード検索"
    let input: String = ""

    
    @IBOutlet weak var flickrSearchBar: UISearchBar?
    
    @IBOutlet var photoCollectionView: FlickrCollectionView?
    
}

extension FlickrView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    }
    
}