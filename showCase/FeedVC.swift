//
//  FeedVC.swift
//  showCase
//
//  Created by 蔡智斌 on 16/6/7.
//  Copyright © 2016年 NeoChoi. All rights reserved.
//

import UIKit
import Firebase
import Alamofire



class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    static var imageCache = NSCache()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 358
        
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: {   snapshot in
            print(snapshot.value)
            
            self.posts = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]{
                for snap in snapshots{
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String,AnyObject>{
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        
                        self.posts.append(post)
                    }
                    
                }
            }
    
            self.tableView.reloadData()
            
        })
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3  //出现3个tabeleViewCell
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let post = posts[indexPath.row]
//        print(post.postDescription)
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell{
            cell.request?.cancel()
            var img: UIImage?
            
            if let url = post.imageUrl{
                img = FeedVC.imageCache.objectForKey(url) as? UIImage
            }
            cell.configureCell(post,img: img)
            return cell
        }else{
            return PostCell()
        }
//        return tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell //delete from part 11
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let post = posts[indexPath.row]
        if post.imageUrl == nil{
            return 200
        }else{
            return tableView.estimatedRowHeight
        }
    }

}
