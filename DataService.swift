//
//  DataService.swift
//  showCase
//
//  Created by 蔡智斌 on 16/6/2.
//  Copyright © 2016年 NeoChoi. All rights reserved.
//

import Foundation
import Firebase

class DataService{
    static let ds = DataService()
    private var _REF_BASE = Firebase(url: "https://showcase12.firebaseio.com")
    var REF_BASE: Firebase{
        return _REF_BASE
    }
}
