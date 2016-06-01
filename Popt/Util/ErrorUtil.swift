//
//  ErrorUtil.swift
//  Popt
//
//  Created by Tomooki on 2016/05/18.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit

class ErrorUtil: NSObject {
    
    private let slack: SlackComponent!
    
//MARK: シングルトン設定
    static var shared : ErrorUtil = {
        return ErrorUtil()
    }()
    
    private override init() {
        self.slack = SlackComponent()
    }
    
//MARK: Warning - 操作に影響しないレベル
    func warning(text : AnyObject){
        self.slack.postToChannel(
            text as! String,
            channel: API.SLACK.WEB_HOOK_URL.WARNING_CH
        )
    }
    
    func warningNotPostSlack(text : AnyObject){
        print("warning - \(text)")
    }
    
//MARK: Alert - 操作に影響するレベル
    func alert(text : AnyObject){
        self.slack.postToChannel(
            text as! String,
            channel: API.SLACK.WEB_HOOK_URL.WARNING_CH
        )
    }
    
}
