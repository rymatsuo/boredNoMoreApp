# boredNoMoreApp

Third app that was successfully released to the App Store. The basic idea for this app is to connect to the public external Bored API and make a request to display a random activity for people who are bored. The app uses a swipe mechanic that is very similar to Tinder. Users can swipe to the left to remove the card and make another API call for another random activity. Alternatively, the user can swipe to the right to save the activity into a table view that has persistance. The table view has functionallity for marking activities as completed and permanently deleting items from the table view.

View app on the App Store: https://apps.apple.com/us/app/id1527474537

This app incorporated the following technologies:
1. Detecting Swipe Gestures UIPanGestureRecognizer()
2. Making a network call to an external API using Apple's URLSessionManager().
3. Parsing a JSON and decoding data using Codable into a usable Swift object.
4. Updating the UI to display returned data contents.
5. Persistent data that is managed using a custom plist.
6. Use of TabViewController to diplay organize the Home and Favorites Views.
