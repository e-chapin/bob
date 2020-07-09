module.exports = (robot) ->

  robot.on "setlistreminder", (context) ->

    d = new Date()
    d.setDate(d.getDate() + (1 + 6 - d.getDay()) % 7)
    d.setDate(d.getDate() + 7)

    data = JSON.stringify({
        "channel":process.env.TESTBOB, 
        "as_user": 1,
        "link_names": 1,
        "blocks": [
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "Confirm setlist for two weeks from tomorrow:"
                }
            },
            {
                "type": "actions",
                "elements": [
                    {
                        "type": "datepicker",
                        "initial_date": d.toISOString().split('T')[0],
                        "placeholder": {
                            "type": "plain_text",
                            "text": "Select a date",
                            "emoji": true
                        }
                    }
                ]
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "Assigned to:"
                },
                "accessory": {
                    "type": "users_select",
                    "initial_user": process.env.JASON_USER
                }
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "Set list status:"
                },
                "accessory": {
                    "type": "static_select",
                    "initial_option": {
                        "text": {
                            "type": "plain_text",
                            "text": "unconfirmed",
                            "emoji": true
                        },
                        "value": "value-0"
                    },
                    "options": [
                        {
                            "text": {
                                "type": "plain_text",
                                "text": "unconfirmed",
                                "emoji": true
                            },
                            "value": "value-0"
                        },
                        {
                            "text": {
                                "type": "plain_text",
                                "text": "waiting on feedback",
                                "emoji": true
                            },
                            "value": "value-1"
                        },
                        {
                            "text": {
                                "type": "plain_text",
                                "text": "songs confirmed",
                                "emoji": true
                            },
                            "value": "value-2"
                        },
                        {
                            "text": {
                                "type": "plain_text",
                                "text": "keys confirmed",
                                "emoji": true
                            },
                            "value": "value-3"
                        }
                    ]
                }
            },
            {
                "type": "actions",
                "elements": [
                    {
                        "type": "button",
                        "text": {
                            "type": "plain_text",
                            "text": "Complete?",
                            "emoji": true
                        },
                        "value": "click_me_123"
                    }
                ]
            }
        ]
    })

    robot.http(process.env.SLACK_ENDPOINT)
        .header('Content-Type', 'application/json')
        .header('Authorization', 'Bearer '+process.env.HUBOT_SLACK_TOKEN)
        .post(data)
