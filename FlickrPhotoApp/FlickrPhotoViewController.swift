//
//  Flickr ViewController.swift
//  FlickrPhotoApp
//
//  Created by NishiokaKohei on 2016/12/17.
//  Copyright © 2016年 Kohey. All rights reserved.
//

import UIKit

protocol PhotoViewControllerDelegate {
    
    func searchingForText(text: String)
    
}


class FlickrViewController: UIViewController {
    
    // MARK: - Properties
    let reuseIdentifier = "flickrCell"
    let flickr = Flickr()
    
    @IBOutlet weak var flickrView: FlickrView?
    
    var dataSource: UICollectionViewDataSource?
    var delegate: UICollectionViewDelegate?
    var searches = NSArray() as! [Photo]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flickrView?.delegate = self
        self.dataSource = self
        self.delegate = self
        flickrView?.flickrCollectionView!.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


// MARK: - UICollectionViewDataSource

extension FlickrViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return searches.count
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier,
                                                                         forIndexPath: cellForItemAtIndexPath) as? FlickrCell
        cell?.backgroundColor = UIColor.blackColor()
        
        guard let urlString = Flickr.photoSource(searches[cellForItemAtIndexPath.row]) else {
            return cell!
        }
        
        let photoURL = NSURL(string: urlString)
        let reqest = NSURLRequest(URL:photoURL!)
        
        // 非同期通信で画像ダウンロード
        NSURLConnection
            .sendAsynchronousRequest(reqest,
                                     queue:NSOperationQueue
                                        .mainQueue()) { (res, data, err) in
                                            
                                            if let image = UIImage(data:data!) {
                                                print(image)
                                                cell?.photoImage?.image = image
                                            } else if let error = err {
                                                print(error)
                                            }
                                            
        }
        
        return cell!
    }
    
}

extension FlickrViewController: UICollectionViewDelegate {
    
}


extension FlickrViewController: FlickrViewDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        // キーボード非表示
        searchBar.resignFirstResponder()
        
        // 接続状態
        let reaching = CheckReachability()
        if !reaching.checkReachability("https://google.com") {
            print("Fail conneting")
        }
        
        // 検索ボタン クリック後の処理
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        flickrView!.flickrCollectionView!.addSubview(activityIndicator)
        activityIndicator.frame = flickrView!.bounds
        activityIndicator.startAnimating()
        
        if flickr.searchFlickrForTerm(searchBar.text!) {
            
            // インジケータ停止
            activityIndicator.removeFromSuperview()
            
            guard let pages = flickr.result as [Page]? else {
                return
            }

            for page in pages {
                print(" page : \(page)")
                let photos = page.photos
                
                var items = [Photo]()
                for photo in photos {
                    let item = photo as Photo?
                    print(item?.title)
                    items.append(item!)
                }
                searches = items as [Photo]
                
            }
            
            // リロード処理
            flickrView!.flickrCollectionView?.reloadData()
            
        } else {
            // アラート表示
            print("Fail to download")
            activityIndicator.removeFromSuperview()
        }
        return
        
    }
    
}



import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

