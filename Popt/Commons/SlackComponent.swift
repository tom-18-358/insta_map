//
//  SlackComponent.swift
//  Popt
//
//  Created by Tomooki on 2016/06/01.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit
import Alamofire

class SlackComponent: NSObject {
    
    func postToChannel(text: String, channel: String) {
        let body:[String: String] = [
            "text" : text
        ]
        let header:[String: String] = [
            "Content-Type" : "application/json"
        ]
        
        Request.shared.request(
            HTTP_METHOD.POST,
            url: channel,
            body: body,
            header:  header,
            callBack: {_ in
        })
    }

}
