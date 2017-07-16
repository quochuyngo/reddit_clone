# *Reddit Clone*
**Reddit** is a social news aggregation app, powered by their users’ upvotes and downvotes. When a user makes a contribution to their website, other users may upvote or downvote a particular topic, giving rise to a set of topics that are popular and unpopular.

Original: https://www.reddit.com/

## User Stories
The following **required** functionality is completed:

- [ ] Maintain a list of topics and its upvotes/downvotes.
- [ ] Allow the user to submit topics. For this challenge, a “topic” is simply a string that does not exceed 255 characters.
- [ ] Allow the user to upvote or downvote a topic. For this challenge, the user may upvote or downvote the same topic multiple times.
- [ ] Always return a list of top 20 topics (sorted by upvotes, descending) on the homepage.
- [ ] In-memory: Design an in-memory data structure (shared by the same process as your application) that will allow you to keep the topics in memory without using data persistence. It is okay for the topics to disappear after the application restarts.
