# Blocmetrics

## Summary

Blocmetrics is an app built to solve the problem of tracking user activities on on you web application. Users are able to register their applications through their account. Then, after including a minor javascript snippet into their codebase, which creates "events" in the Blocmetrics database, users have access to visualizations of their own users' activities.

## Setup

To get setup locally, run the following commands (requires Rails):

```
$ bundle install
$ rake db:create
$ rake db:migrate
```

To run the app locally, issue one last command: `$ rails server`.

## Additional Information

Blocmetrics allows users to register their domain with their account on the site. Those domains are stored, and all incoming post requests are checked against the registered domains. Here is the javascript snippet required by users in order to post information to Blocmetrics:

```JavaScript
var blocmetrics = {};
blocmetrics.report = function(eventName) {
  var event = {event: { name: eventName }};
  var request = new XMLHttpRequest();
  request.open('POST', "http://blocmetrics/api/events", true);
  request.setRequestHeader('Content-Type', 'application/json');
  request.send(JSON.stringify(event));
}
```

In order to post data to a local version of the application, you will need to change the address (`"http://blocmetrics/api/events"`) to that of your local instance.
