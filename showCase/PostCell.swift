//
//  PostCell.swift
//  showCase
//
//  Created by 蔡智斌 on 16/6/7.
//  Copyright © 2016年 NeoChoi. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    var post: Post!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    @IBOutlet weak var descriptionText:UITextView!
    @IBOutlet weak var likesLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post){
        
        self.post = post
        
        self.descriptionText.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
    }

    
    
    override func drawRect(rect: CGRect) {
        
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        showcaseImg.clipsToBounds = true
        
    }
}
