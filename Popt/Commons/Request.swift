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
    func faild()
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
    func request(method : String, url : String, callBack:(result : JSON) -> Void) -> Void {
        self.convertMethod(method)
        
        Alamofire.request(_method, url)
            // TODO:errorハンドリングせねば
            .responseJSON { response in
                guard let _response = response.result.value else {
                    ErrorUtil.shared.warning(" - API取得失敗 \n url : " + url)
                    print(response)
                    self.requestDelegate?.faild()
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