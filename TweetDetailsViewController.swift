//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Vicky Tang on 2/28/17.
//  Copyright © 2017 Vicky Tang. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!
    
    func formatDate(dates: Date) -> String {
        let currentCalendar = Calendar.current
        let currentTimer = Date()
        let flags: NSCalendar.Unit =
            [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (currentCalendar as NSCalendar).components(flags, from: dates,to: currentTimer, options: [])
        
        if let year = components.year, year >= 2 {
            return "\(year)y"
        }
        
        if let year = components.year, year >= 1 {
            return "Last year"
        }
        
        if let month = components.month, month >= 2{
            return "\(month)m"
        }
        
        if let month = components.month, month >= 1 {
            return "Last month"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "\(week)w"
        }
        
        if let week = components.weekOfYear, week >= 1{
            return "Last week"
        }
        
        if let day = components.day, day >= 1 {
            return "\(day)d"
        }
        
        if let hour = components.hour, hour >= 1{
            return "\(hour)h"
        }
        
        if let minute = components.minute, minute >= 1{
            return "\(minute)m"
        }
        
        if let second = components.second, second >= 1{
            return "\(second)s"
        }
        
        return "Now"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetImageView.layer.cornerRadius = 4
        tweetImageView.clipsToBounds = true
        
        if let profileURL = tweet.user?.profileUrl{
            self.tweetImageView.setImageWith(profileURL as URL)
        }
        
        self.nameLabel.text = tweet.user?.name as String?
        self.usernameLabel.text = "@\((tweet.user?.screenname as String?)!)"
        self.tweetTextLabel.text = tweet.text as String?
        self.timestampLabel.text = formatDate(dates: tweet.timestamp as! Date)
        self.retweetLabel.text = "\((tweet.retweetCount))"
        self.favoriteLabel.text = "\((tweet.favoritesCount))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReplyPresed(_ sender: Any) {
        print("Reply pressed")
    }

    @IBAction func onRetweetPressed(_ sender: Any) {
        if(tweet.didRetweet == false){
            TwitterClient.sharedInstance!.retweet(id: (tweet.id), success: {
                self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
                self.tweet.retweetCount += 1
                self.retweetLabel.text = "\((self.tweet.retweetCount))"
                self.tweet.didRetweet = true
            }, failure: { (error) in
                print("Error: \(error.localizedDescription)")
            })
        } else if (tweet.didRetweet == true) {
            TwitterClient.sharedInstance!.unretweet(id: (tweet.id), success: {
                self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
                self.tweet.retweetCount -= 1
                self.retweetLabel.text = "\((self.tweet.retweetCount))"
                self.tweet.didRetweet = false
            }, failure: { (error) in
                print("Error: \(error.localizedDescription)")
            })
        }
    }
    
    @IBAction func onFavoritePressed(_ sender: Any) {
        if(tweet.didFavorite == false){
            TwitterClient.sharedInstance!.favorite(id: (tweet.id), success: {
                self.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
                self.tweet.favoritesCount += 1
                self.favoriteLabel.text = "\((self.tweet.favoritesCount))"
                self.tweet.didFavorite = true
            }, failure: { (error) in
                print("Error: \(error.localizedDescription)")
            })
        } else if (tweet.didFavorite == true) {
            TwitterClient.sharedInstance!.unfavorite(id: (tweet.id), success: {
                self.favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)
                self.tweet.favoritesCount -= 1
                self.favoriteLabel.text = "\((self.tweet.favoritesCount))"
                self.tweet.didFavorite = false
            }, failure: { (error) in
                print("Error: \(error.localizedDescription)")
            })
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DetailToProfileSegue"){
            //let button = sender as! UIButton
            let detailViewController = segue.destination as! ProfileViewController
            detailViewController.tweet = tweet
        } else if (segue.identifier == "DetailToTweetSegue") {
            let detailViewController = segue.destination as! UpdateStatusViewController
            detailViewController.tweet = tweet
        }
    }
    

}
