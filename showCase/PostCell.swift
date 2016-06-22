//
//  PostCell.swift
//  showCase
//
//  Created by 蔡智斌 on 16/6/7.
//  Copyright © 2016年 NeoChoi. All rights reserved.
//

import UIKit
import Firebase
import Alamofire


class PostCell: UITableViewCell {
    

    
    var post: Post!
    var request: Request? //belone to Alamofire
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    @IBOutlet weak var descriptionText:UITextView!
    @IBOutlet weak var likesLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post,img: UIImage?){
        
        if post.imageUrl != nil{
            
            if img != nil{
                self.showcaseImg.image = img
            }else{
                request = Alamofire.request(.GET, post.imageUrl!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
                    if err == nil{
                        let img = UIImage(data: data!)!
                        self.showcaseImg.image = img
                        FeedVC.imageCache.setObject(img, forKey: self.post.imageUrl!)
                    }
                
                })
            }
            
        }else{
            self.showcaseImg.hidden = true
        }
        
        self.post = post
        
        self.descriptionText.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
    }

    
    
    override func drawRect(rect: CGRect) {
        
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        showcaseImg.clipsToBounds = true
        
    }
}
