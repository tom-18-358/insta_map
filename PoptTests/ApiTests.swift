import Quick
import Nimble
import Alamofire
import Foundation
@testable import Popt

class ApiTests: QuickSpec {
    
    private var _method = Method.GET
    
    override func spec() {
        describe("API挙動") {
            context("Slack") {
                self.slackTest()
            }
            context("Instagram") {
                self.instagramTest()
            }
        }
    }
    
    
//MARK: Slack API
    private func slackTest() {
        it("投稿が出来るか") {
            self.request(
                HTTP_METHOD.POST,
                url:     TEST.API_.SLACK.POST_URL,
                body:    TEST.API_.SLACK.BODY,
                headers: TEST.API_.SLACK.HEADERS
            )
        }
    }

    
//MARK: Instagram API
    private func instagramTest() {
        it("付近の場所情報を取得できるか") {
            self.request(
                HTTP_METHOD.GET,
                url:     TEST.API_.INSTAGRAM.GET_LOCALES_BY_LOCALE_URL,
                body:    nil,
                headers: nil
            )
        }
        it("場所IDから投稿を取得できるか") {
            self.request(
                HTTP_METHOD.GET,
                url:     TEST.API_.INSTAGRAM.GET_ARTICLES_BY_LOCALE_URL,
                body:    nil,
                headers: nil
            )
        }
    }
    
    
//MARK: Request Method
    /**
     requestのstatusCodeを確認
     200以外でテスト失敗
     
     - parameter method:  HTTP_METHOD
     - parameter url:     リクエストするURL
     - parameter body:    リクエストに追加するBODY
     - parameter headers: リクエストに追加するHEADER
     */
    private func request(method: String, url: String, body: [String: String]?, headers: [String: String]?) {
        var responseStatus: Bool = false
        self.convertMethod(method)
        Alamofire.request(
            _method,
            url,
            parameters: body,
            encoding: .JSON,
            headers: headers
            ).response { (request, response, data, error) -> Void in
                if response?.statusCode == TEST.API_.VALID_STATUS_CODE {
                    responseStatus = true
                }
        }
        expect(responseStatus).toEventually(equal(true), timeout: TEST.API_.VALID_TIMEOUT_SEC)
    }
    
    /**
     HttpMethodをAlmofire用の型に変換
     @param method メソッド名
     */
    private func convertMethod(method: String) {
        switch method {
        case "PUT":
            _method = Method.PUT
        case "POST":
            _method = Method.POST
        case "PATCH":
            _method = Method.PATCH
        case "DELETE":
            _method = Method.DELETE
        default:
            _method = Method.GET
        }
    }
}
