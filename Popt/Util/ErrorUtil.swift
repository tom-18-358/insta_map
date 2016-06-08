//
//  ErrorUtil.swift
//  Popt
//
//  Created by Tomooki on 2016/05/18.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit
import SVProgressHUD

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
    func warning(text : AnyObject, toCustomerText: String?) {
        self.slack.postToChannel(
            text as! String,
            channel: API.SLACK.WEB_HOOK_URL.WARNING_CH
        )
        
        if toCustomerText != nil {
            warningToCustomer(toCustomerText!)
        }
        
    }
    
    func warningNotPostSlack(text : AnyObject){
        print("warning - \(text)")
    }
    
//MARK: Alert - 操作に影響するレベル
    func alert(text : AnyObject, toCustomerText: String?) {
        self.slack.postToChannel(
            text as! String,
            channel: API.SLACK.WEB_HOOK_URL.ALERT_CH
        )
        
        if toCustomerText != nil {
            warningToCustomer(toCustomerText!)
        }
    }
    
//MARK: ViewにWarningを表示する
    private func warningToCustomer(text: String) {
        let info: [String: String] = ["title": "エラー", "message": text];
        let n : NSNotification = NSNotification(name: "showAlert", object: self, userInfo: ["info": info])
        NSNotificationCenter.defaultCenter().postNotification(n)
    }
    
}
