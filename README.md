# Project 4 - *Twitter*

**Twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign in using OAuth login flow
- [X] User can view last 20 tweets from their home timeline
- [X] The current signed in user will be persisted across restarts
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [X] Retweeting and favoriting should increment the retweet and favorite count.

The following **optional** features are implemented:

- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [ ] User can pull to refresh.

The following **additional** features are implemented:

- [X] Customized Navigation Bar (Blue bar, white text)
- [X] Customized status bar (from black to white)
- [X] Retweet/Favorites button changes color when pressed

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Customize retweet before posting
2. Post your own tweet

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/nQ0lujA.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

[Link to GIF Walkthrough](http://i.imgur.com/nQ0lujA.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

- Autolayout was difficult with the extra retweet/favorite/reply button
- Had difficulty implementing User in Tweet.

## License

    Copyright [2017] [Vicky Cheng Tang]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

# Project 5 - *Twitter*

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [X] Profile page:
   - [X] Contains the user header view
   - [X] Contains a section with the users basic stats: # tweets, # following, # followers
- [X] Home Timeline: Tapping on a user image should bring up that user's profile page
- [X] Compose Page: User can compose a new tweet by tapping on a compose button.

The following **optional** features are implemented:

- [ ] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] Profile Page
   - [ ] Implement the paging view for the user description.
   - [ ] As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
   - [ ] Pulling down the profile page should blur and resize the header image.
- [ ] Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account

The following **additional** features are implemented:

- [X] Images have rounded edges
- [X] Imported custom font for Twitter login page
- [X] User can access the profile page by tapping image in the detail view
- [X] Profile page also contains the selected user's latest posts

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Adding hyperlinks to any links that users may have tweeted
2. Implementing follow/friend

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/AH28m3E.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

[Link to GIF Walkthrough](http://i.imgur.com/AH28m3E.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

- Had difficulties implementing the tableview in the profile page. Kept getting the authorized user's timeline instead
  of the selected profile user's timeline

## License

    Copyright [2017] [Vicky Cheng Tang]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
