module.exports = (robot) ->

  robot.hear /testing/i, (res) ->
    # robot.respond
    robot.emit "setlistreminder", {
        user    : {}, #hubot user object
        test: 123
    }