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

    struct SLACK {
        struct WEB_HOOK_URL {
            static let BASE       = "https://hooks.slack.com/services/"
            static let WARNING_CH = API.SLACK.WEB_HOOK_URL.BASE + "TYPE_CH"
            static let ALERT_CH   = API.SLACK.WEB_HOOK_URL.BASE + "TYPE_CH"
        }
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


//MARK: USE TEST
struct TEST {
    struct API_ {
        struct SLACK {
            static let POST_URL: String          = "https://hooks.slack.com/services/TYPE_CH"
            static let BODY: [String: String]    = ["text" : "slack test is ok"]
            static let HEADERS: [String: String] = ["Content-Type" : "application/json"]
        }
        struct INSTAGRAM {
            static let GET_LOCALES_BY_LOCALE_URL: String  =
                API.INSTA.BASE_URL
                + API.INSTA.PRAM.LOCATIONS
                + API.INSTA.PRAM.SEARCH
                + API.INSTA.PRAM.ACCESS_TOKEN
                + API.INSTA.PRAM.LAT + "35.533127"
                + API.INSTA.PRAM.LNG + "139.701059"
                + API.INSTA.PRAM.DISTANCE + API.INSTA.SEARCH_DISTANCE
            static let GET_ARTICLES_BY_LOCALE_URL: String =
                API.INSTA.BASE_URL
                + API.INSTA.PRAM.LOCATIONS
                + "/238512754"
                + API.INSTA.PRAM.MEDIA_RECENT
                + API.INSTA.PRAM.ACCESS_TOKEN
        }
        static let VALID_STATUS_CODE: Int    = 200
        static let VALID_TIMEOUT_SEC: Double = 10
    }
}