# Show specified ticket info from Kanbanery
#
# bug|issue|task|ticket #<number> - Show data about Kanbanery ticket
module.exports = (robot) ->
  robot.hear /(tickets?|tasks?|issues?|bugs?) ##?(\d{6})/i, (msg) ->
    id = msg.match[2]
    getData(msg, id)

apiToken = -> "api_token=#{process.env.HUBOT_KANBANERY_TOKEN}"

workspace = -> "#{process.env.HUBOT_KANBANERY_WORKSPACE}"

getIssue = (msg, id, handler) ->
  issue_url = "https://#{workspace()}.kanbanery.com/api/v1/tasks/#{id}.json?#{apiToken()}"
  msg.http(issue_url).get() (err, res, body) ->
    try
      issue = JSON.parse(body)
      handler issue
    catch e
      if body == "404 Not Found"
        msg.send "Ticket ##{id} not found"

getColumn = (msg, id, handler) ->
  column_url = "https://#{workspace()}.kanbanery.com/api/v1/columns/#{id}.json?#{apiToken()}"
  msg.http(column_url).get() (err, res, body) ->
    try
      column = JSON.parse(body)
      handler column
    catch e

getData = (msg, id) ->
  getIssue msg, id, (issue) ->
    getColumn msg, issue.column_id, (column) ->
      msg.send "Ticket ##{id}: #{issue.title}"

      message = "Currently"
      message += " blocked" if issue.blocked
      message += " ready to pull" if issue.ready_to_pull
      message += " in #{column.name}"
      msg.send message

      msg.send "#{issue.global_in_context_url}"
