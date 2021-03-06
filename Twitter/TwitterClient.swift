//
//  TwitterClient.swift
//  Twitter
//
//  Created by Vicky Tang on 2/23/17.
//  Copyright © 2017 Vicky Tang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

fileprivate let ScreenNamekey = "screen_name"

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "fxxiY2HgFrg1EqqDAiRAea9KY", consumerSecret: "MG224M1rA1d7meDhJU4YgsxbW3NzkRwWdISiPtA8M1DDOJQIPS")
    static let oAuthBaseURL = "https://api.twitter.com"
    static let userProfieTimeLineEndPoint = oAuthBaseURL + "/1.1/statuses/user_timeline.json"
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth") as URL!, scope: nil, success: {(requestToken: BDBOAuth1Credential?) -> Void in
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url!)
            }
            
        }) { (error: Error?) -> Void in
            print("error: \(error!.localizedDescription)")
            self.loginFailure!(error!)
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) -> () in
                self.loginFailure!(error)
            })

        }) { (error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure!(error!)
        }

    }
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func retweet(id: Int, success :@escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task, response) in success()
        }) { (task, error) in
            failure(error)
        }
    }
    
    func unretweet(id: Int, success :@escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("1.1/statuses/unretweet/\(id).json", parameters: nil, progress: nil, success: { (task, response) in success()
        }) { (task, error) in
            failure(error)
        }
    }
    
    func favorite(id: Int, success :@escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task, response) in success()
        }) { (task, error) in
            failure(error)
        }
    }
    
    func unfavorite(id: Int, success :@escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("1.1/favorites/destroy.json?id=\(id)", parameters: nil, progress: nil, success: { (task, response) in success()
        }) { (task, error) in
            failure(error)
        }
    }
    
    func statusUpdate(id: Int, tweetStatus: String, tweetID: String, success :@escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("1.1/statuses/update.json", parameters: ["status": tweetStatus, "in_reply_to_status_id": tweetID], progress: nil, success: { (task, response) in success()
        }) { (task, error) in
            failure(error)
        }
    }
    
    func userTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/user_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func getUserProfileTimeLine(userScreenName: String, callBack: @escaping (_ response: [Tweet]?, _ error: Error? ) -> Void){
        let fetchURLString = TwitterClient.userProfieTimeLineEndPoint
        let param: [String : Any] = [ScreenNamekey: userScreenName]  //extra param to fetch whatever profile you want based on the screen name
        let _ = TwitterClient.sharedInstance?.get(fetchURLString, parameters: param, progress: nil, success: { (task: URLSessionDataTask, response:Any?) in
            //this is the desired timeline for the given user
            if let timelineDict = response as? [[String: Any]]{
                let tweets = timelineDict.map{(element) -> Tweet in
                    return Tweet(dictionary: element as NSDictionary)
                }
                callBack(tweets, nil)
            }
        }, failure: { (task: URLSessionDataTask?, error:Error) in
            print(error.localizedDescription)
            callBack(nil, error)
        })
    }
    
}
