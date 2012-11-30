module.exports = (robot) ->
  robot.respond /ticketbotxe.*help\s*(.*)?$/i, (msg) ->
    cmds = robot.helpCommands()
    if msg.match[1]
      cmds = cmds.filter (cmd) -> cmd.match(new RegExp(msg.match[1], 'i'))
    emit = cmds.join("\n")
    unless robot.name is 'Hubot'
      emit = emit.replace(/(H|h)ubot/g, robot.name)
    msg.send emit
