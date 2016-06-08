//
//  Request.swift
//  QiitaFeed
//
//  Created by Tomooki on 2016/04/20.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

protocol RequestDelegate {
    func success(result: JSON)
}

class Request: NSObject {
    
    var requestDelegate : RequestDelegate?
    private var _method = Method.GET
    
    // シングルトン設定
    static var shared : Request = {
        return Request()
    }()
    
    private override init() {
    }
    
    /**
     API通信実行
     
     - parameter method:   HttpMethod
     - parameter url:      API URL
     - parameter callBack: 取得成功時のcallBack関数
     */
    func request(method: String, url: String, body: [String: String]? ,header: [String: String]? ,callBack:(result : JSON) -> Void) -> Void {
        self.convertMethod(method)
        
        //Slack通知の時はrespoceがStringなので別処理
        if url.containsString(API.SLACK.WEB_HOOK_URL.BASE) {
            Alamofire.request(
                _method,
                url,
                parameters: body,
                encoding: .JSON,
                headers: header
            ).response { (request, response, data, error) -> Void in
                if response?.statusCode != 200 {
                    ErrorUtil.shared.warningNotPostSlack(response.debugDescription)
                }
            }
            return
        }
        
        Alamofire.request(
            _method,
            url,
            parameters: body,
            encoding: .JSON,
            headers: header
        ).responseJSON { response in
            guard let _response = response.result.value else {
                ErrorUtil.shared.alert(
                    "API取得失敗 \n  url : \(url) \n  response : \(response)",
                    toCustomerText: "投稿取得失敗"
                )
                return
            }
            let meta = _response["meta"] as! NSDictionary
            if meta["code"] as! Int != 200 {
                ErrorUtil.shared.alert(
                    "API取得失敗 \n  url : \(url) \n  response : \(response)",
                    toCustomerText: "投稿取得失敗"
                )
                return
            }
            
            if response.result.isFailure {
                ErrorUtil.shared.alert(
                    "API取得失敗 \n  url : \(url) \n  response : \(response)",
                    toCustomerText: "投稿取得失敗"
                )
                return
            }
            callBack(result: JSON(_response))
        }
    }
    
    /**
     HttpMethod毎にレスポンス処理を変更
     TODO: これは一時的なもんです。作り込んでいく中でモデルも選べるようにする
     */
    private func distributesResponce(response: AnyObject) {
        switch _method {
        case Method.GET:
            self.requestDelegate?.success(JSON(response))
        case Method.PUT:
            SVProgressHUD.dismiss()
        case Method.POST:
            SVProgressHUD.dismiss()
        case Method.PATCH:
            SVProgressHUD.dismiss()
        case Method.DELETE:
            SVProgressHUD.dismiss()
        default:
            _method = Method.GET
        }
    }
    
    /**
     HttpMethodをAlmofire用の型に変換
     @param method メソッド名
     */
    private func convertMethod(method: String) {
        switch method {
        case HTTP_METHOD.PUT:
            _method = Method.PUT
        case HTTP_METHOD.POST:
            _method = Method.POST
        case HTTP_METHOD.PATCH:
            _method = Method.PATCH
        case HTTP_METHOD.DELETE:
            _method = Method.DELETE
        default:
            _method = Method.GET
        }
        
    }
    
}