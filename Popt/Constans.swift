//
//  Constans.swift
//  QiitaFeed
//
//  Created by Tomooki on 2016/04/20.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import Foundation

/**
 *  API周りの情報
 */
struct API {
    
    struct INSTA {
        static let BASE_URL        = "https://api.instagram.com" + API.INSTA.VER
        static let VER             = "/v1"
        static var ACCESS_TOKEN    = "TYPE_YOUR_TOKEN"
        static var SEARCH_DISTANCE = "750"
        struct PRAM {
            static let ACCESS_TOKEN = "?access_token=" + API.INSTA.ACCESS_TOKEN
            static let LOCATIONS    = "/locations"
            static let MEDIA_RECENT = API.INSTA.PRAM.MEDIA + API.INSTA.PRAM.RECENT
            static let MEDIA        = "/media"
            static let RECENT       = "/recent"
            static let SEARCH       = "/search"
            static let LAT          = "&lat="
            static let LNG          = "&lng="
            static let DISTANCE     = "&distance="
        }
    }
    
    struct GOOGLE_MAP {
        static let API_KEY = "AIzaSyBGEKokIgWdHhhfda9P1DV5uwUANNoXACA"
    }
}

/**
 *  HTTP method名
 */
struct HTTP_METHOD {
    static let GET    = "GET"
    static let PUT    = "PUT"
    static let POST   = "POST"
    static let PATCH  = "PATCH"
    static let DELETE = "DELETE"
}
