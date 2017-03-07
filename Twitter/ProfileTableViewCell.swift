//
//  ProfileTableViewCell.swift
//  Twitter
//
//  Created by Vicky Tang on 3/6/17.
//  Copyright © 2017 Vicky Tang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel : UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //var profileController = UIViewController as ProfileViewController
    //var profileUser = profileController.user
    
    var tweetData: Tweet? {
        didSet{
            print("PostData has been set")
            let userModel = tweetData?.user
            self.tweetTextLabel.text = self.tweetData?.text as String?
            
            if let profileURL = userModel?.profileUrl{
                self.tweetImageView.setImageWith(profileURL as URL)
            }
            
            self.nameLabel.text = userModel?.name as String!
            self.usernameLabel.text = "@\((userModel?.screenname as String!)!)"
            self.timestampLabel.text = formatDate(dates: self.tweetData?.timestamp as! Date)
            self.retweetCountLabel.text = "\((self.tweetData?.retweetCount)!)"
            self.favoriteCountLabel.text = "\((self.tweetData?.favoritesCount)!)"
        }
    }
    
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
    
    @IBAction func onRetweetPressed(_ sender: Any) {
        if(tweetData?.didRetweet == false){
            TwitterClient.sharedInstance!.retweet(id: (tweetData?.id)!, success: {
                self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
                self.tweetData?.retweetCount += 1
                self.retweetCountLabel.text = "\((self.tweetData?.retweetCount)!)"
                self.tweetData?.didRetweet = true
            }, failure: { (error) in
                print("Error: \(error.localizedDescription)")
            })
        } else if (tweetData?.didRetweet == true) {
            TwitterClient.sharedInstance!.unretweet(id: (tweetData?.id)!, success: {
                self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
                self.tweetData?.retweetCount -= 1
                self.retweetCountLabel.text = "\((self.tweetData?.retweetCount)!)"
                self.tweetData?.didRetweet = false
            }, failure: { (error) in
                print("Error: \(error.localizedDescription)")
            })
        }
    }

    @IBAction func onFavoritePressed(_ sender: Any) {
        if(self.tweetData?.didFavorite == false){
            TwitterClient.sharedInstance!.favorite(id: (tweetData?.id)!, success: {
                self.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
                self.tweetData?.favoritesCount += 1
                self.favoriteCountLabel.text = "\((self.tweetData?.favoritesCount)!)"
                self.tweetData?.didFavorite = true
            }, failure: { (error) in
                print("Error: \(error.localizedDescription)")
            })
        } else if (self.tweetData?.didFavorite == true) {
            TwitterClient.sharedInstance!.unfavorite(id: (tweetData?.id)!, success: {
                self.favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)
                self.tweetData?.favoritesCount -= 1
                self.favoriteCountLabel.text = "\((self.tweetData?.favoritesCount)!)"
                self.tweetData?.didFavorite = false
            }, failure: { (error) in
                print("Error: \(error.localizedDescription)")
            })
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tweetImageView.layer.cornerRadius = 4
        tweetImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
