//
//  ErrorUtil.swift
//  Popt
//
//  Created by Tomooki on 2016/05/18.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit

class ErrorUtil: NSObject {
    
    // シングルトン設定
    static var shared : ErrorUtil = {
        return ErrorUtil()
    }()
    
    private override init() {
    }

    func warning(text : String){
        print("warning - " + text)
    }

}
