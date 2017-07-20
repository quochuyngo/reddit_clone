# *Reddit Clone*
**Reddit** is a social news aggregation app, powered by their users’ upvotes and downvotes. When a user makes a contribution to their website, other users may upvote or downvote a particular topic, giving rise to a set of topics that are popular and unpopular.

Original: https://www.reddit.com/

## User Stories

The following **required** functionality is completed:

- [x] Maintain a list of topics and its upvotes/downvotes.
- [x] Allow the user to submit topics. For this challenge, a “topic” is simply a string that does not exceed 255 characters.
- [x] Allow the user to upvote or downvote a topic. For this challenge, the user may upvote or downvote the same topic multiple times.
- [x] Always return a list of top 20 topics (sorted by upvotes, descending) on the homepage.
- [x] In-memory: Design an in-memory data structure (shared by the same process as your application) that will allow you to keep the topics in memory without using data persistence. It is okay for the topics to disappear after the application restarts.

## Walkthrough

## Documentations
Reddit app written in Swift 3.0
  - **Maintain a list topics and return 20 topics sorted by upvotes**
  
    Create a list of topics.
  ````swift
    /* contents: array content of topic
       pictures: array name of images
       names    : array name of users
    */
    //Topic.swift
    static func createFakeTopics() -> [Topic] {
       var topics = [Topic]()
       for _ in 0..<4 {
            for content in contents {
                //random number of upvotes and downvotes
                let upvotes =  Int(arc4random_uniform(16))
                let downvotes = Int(arc4random_uniform(10))
                //random name and profile picture
                let index = Int(arc4random_uniform(3))
                let profilePicture = pictures[index]
                let name = names[index]
                
                /create a new topic
                let topic = Topic(id: Utils.getUUID()
                                  , user: User(userId: Utils.getUUID(), userName: name, profilePicture: profilePicture)
                                  , createdDate: Date()
                                  , content: content
                                  , upVote: upvotes
                                  , downVote: downvotes
                                  , voteState: .none)
                
                topics.append(topic)
            }
         }
         return topics
    }
  ````
      Sort topics by upvotes
  ````swift
    //BaseViewController.swift
    func sortByUpvotes() -> [Topic]{
        var result = [Topic]()
        result = topics.sorted(by: { $0.upVote > $1.upVote })
        return result
    }
    
    //return 20 topics from sorted list
    func getPopularTopics() -> [Topic] {
        return Array(sortByUpvotes().prefix(20))
    }
  ````
  - **Alow user submit a new topic**
  
    When user click **Done** button, this event will happen.
  ````swift
    //NewTopicViewController.swift
    @IBAction func postAction(_ sender: Any) {
        //create a new topic with content get from UITextView
        let topic = Topic(id: Utils.getUUID()
                          , user: User.currentUser
                          , createdDate: Date()
                          , content: contentTextView.text
                          , upVote: 0
                          , downVote: 0
                          , voteState: .none)
        //use delegate to pass newtopic to HomeViewController
        delegate?.newPost(topic: topic)
        //go back to Home view
        _ = navigationController?.popViewController(animated: true)
    }
  ````
  
   - **Allow user Upvote/Downvote a topic**

    Upvote/downvote will happen when user tap to UpvoteButton
   ````swift
    //TopicCell.swift
    @IBAction func upvoteAction(_ sender: UIButton) {
        if sender.isSelected {
            //user voted already -> update vote state to unvote
            topic?.voteState = .none
        } else {
            //increase number of upvote 
            topic?.upVote += 1 
            //set upvote state and update UI
            topic?.voteState = .upvote
        }
        // use delegate to pass topic changed to HomeViewController
        delegate?.topicDidChanged(topic: self.topic!) 
    }
   ````
