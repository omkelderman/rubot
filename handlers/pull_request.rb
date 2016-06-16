# frozen_string_literal: true

module RubotHandlers::PullRequest
  def self.format_pull_request(pull_request)
    number = "**##{pull_request['number']}**"
    title = %( **#{pull_request['title']}**)
    url = "<#{pull_request['html_url']}>"
    [number, title, url].join("\n")
  end

  def self.handle(payload)
    case payload.action
    when 'opened'
      %(opened a pull request #{format_pull_request(payload['pull_request'])})
    when 'reopened'
      %(re-opened a pull request #{format_pull_request(payload['pull_request'])})
    when 'closed'
      %(#{payload['pull_request']['merged'] ? 'merged' : 'closed'} a pull request #{format_pull_request(payload['pull_request'])})
    when 'assigned'
      %(assigned a pull request #{payload.tiny_pull_request} to **#{payload['assignee']['login']}**
<#{payload['pull_request']['html_url']}>)
    when 'unassigned'
      %(unassigned a pull request #{payload.tiny_pull_request} from **#{payload['assignee']['login']}**
<#{payload['pull_request']['html_url']}>)
    when 'labeled'
      %(added label `[#{payload['label']['name']}]` to a pull request #{payload.tiny_pull_request}
<#{payload['pull_request']['html_url']}>)
    when 'unlabeled'
      %(removed label `[#{payload['label']['name']}]` from a pull request #{payload.tiny_pull_request}
<#{payload['pull_request']['html_url']}>)
    when 'synchronize'
      %(updated a pull request #{payload.tiny_pull_request} with new commits
<#{payload['pull_request']['html_url']}>)
    end
  end
end
