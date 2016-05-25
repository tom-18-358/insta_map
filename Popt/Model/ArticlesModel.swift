//
//  ArticlesModel.swift
//  Popt
//
//  Created by Tomooki on 2016/05/18.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

protocol AriticlesModelDelegate {
    func getedArticles()
}


class ArticlesModel: NSObject {
    
    var ATdelefate: AriticlesModelDelegate!
    
    /**
     *  記事データ
     */
    struct Article {
        let id        : String
        let text      : String
        let tags      : JSON
        let likeCount : Int
        let imgLink   : Img
        let comment   : Comments
        let link      : NSURL
    }
    struct Comments {
        let count   : NSNumber
        let comment : JSON
    }
    struct Img {
        let standardResolutionUrl : NSURL
        let lowResolutionUrl      : NSURL
        let thumbnailUrl          : NSURL
    }

    // PageNationURL
    var nextUrl : String? = nil
    
    // map top に表示させる記事
    var displayedArticle : Article? = nil
    var totalLikeCount: Int?
    var list : [Article] = []
    
    /**
     記事リストをtypeとIDを指定して取得
     
     - parameter url: APIリクスエストするURL
     */
    func generateArticleByUrl(url : String){
        Request.shared.request(
            HTTP_METHOD.GET,
            url: url,
            callBack: {(result : JSON) -> Void in
                self.setArticle(result)
            }
        )
    }
    
    // 投稿がさらにある場合に取得
    func generateNextArticles(){
        if nextUrl?.isEmpty == true {
            return
        }
        generateArticleByUrl(nextUrl!)
    }
    
    
// MARK: - PrivateMethod
    /**
     取得した記事を構造体にはめ込む
     
     - parameter result: 取得した記事@JSON
     */
    private func setArticle(result : JSON){
        let articles = result["data"]
        var maxLike : Int = 0
        totalLikeCount = 0
        nextUrl = result["pagination"]["next_url"].stringValue
        
        articles.forEach{(id, article) in
            if article == nil {
                return
            }
            let img = Img(
                standardResolutionUrl : NSURL(string:article["images"]["standard_resolution"]["url"].string!)!,
                lowResolutionUrl      : NSURL(string:article["images"]["low_resolution"]["url"].string!)!,
                thumbnailUrl          : NSURL(string:article["images"]["thumbnail"]["url"].string!)!
            )
            let comment = Comments(
                count   : article["comments"]["count"].number!,
                comment : article["comments"]["data"]
            )
            let articleStruct = Article(
                id        : article["id"].string!,
                text      : article["caption"]["text"].stringValue,
                tags      : article["tags"],
                likeCount : article["likes"]["count"].intValue,
                imgLink   : img,
                comment   : comment,
                link      : NSURL(string:article["link"].string!)!
            )
            if maxLike < articleStruct.likeCount {
                maxLike = articleStruct.likeCount
                self.displayedArticle = articleStruct
            }
            totalLikeCount = totalLikeCount! + articleStruct.likeCount
            self.list.append(articleStruct)
        }
        self.list = self.list.sort { $0.likeCount < $1.likeCount }
        self.ATdelefate.getedArticles()
    }

}
