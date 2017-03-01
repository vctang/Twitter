//
//  TweetsTableViewCell.swift
//  Twitter
//
//  Created by Vicky Tang on 2/26/17.
//  Copyright © 2017 Vicky Tang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TweetsTableViewCell: UITableViewCell {

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
            self.retweetLabel.text = "\((self.tweetData?.retweetCount)!)"
            self.favoriteLabel.text = "\((self.tweetData?.favoritesCount)!)"
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
        
        return "1000y"
        
    }
    
    @IBAction func onReplyPressed(_ sender: Any) {
        print("Reply pressed")
    }
    
    @IBAction func onRetweetPressed(_ sender: Any) {
        retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
        tweetData?.retweetCount += 1
        self.retweetLabel.text = "\((self.tweetData?.retweetCount)!)"
    }
    
    @IBAction func onFavoritePressed(_ sender: Any) {
        favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
        tweetData?.favoritesCount += 1
        self.favoriteLabel.text = "\((self.tweetData?.favoritesCount)!)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
