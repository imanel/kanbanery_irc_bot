# IRC bot for Kanbanery tickets

It will show you message about mentioned issue on IRC.

## Usage

On irc just say something like:

```
tickets #1234
```

Response:

```
Ticket #1234: Make everything working
Currently blocked in column Code Review
http://my_workspace.kanbanery.com/tasks/1234
```

Valid triggers are: `ticket`, `task`, `issue` and `bug`, followed by '#' and number of ticket. Bot will detect this syntax even in middle of sentence so:

```
What is status of issue #1234?
```

is still detected.

## Installation

Got to `https://kanbanery.com/user/api` to obtain kanbanery token

Deploy to heroku and then:

```
heroku config:add HUBOT_KANBANERY_WORKSPACE="my_workspace"
heroku config:add HUBOT_KANBANERY_TOKEN="token"
```

```
heroku config:add HUBOT_IRC_NICK="hubot"
heroku config:add HUBOT_IRC_ROOMS="#hubot-irc"
heroku config:add HUBOT_IRC_SERVER="irc.freenode.net"
```
