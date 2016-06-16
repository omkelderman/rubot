# frozen_string_literal: true

module RubotHandlers::Issues
  def self.format_issue(issue)
    number = "**##{issue['number']}**"
    title = %( **#{issue['title']}** ) + issue['labels'].map { |e| "`[#{e['name']}]`"}.join(' ')
    url = "<#{issue['html_url']}>"
    [number, title, url].join("\n")
  end

  def self.handle(payload)
    case payload.action
    when 'opened'
      %(opened an issue #{format_issue(payload['issue'])})
    when 'reopened'
      %(re-opened an issue #{format_issue(payload['issue'])})
    when 'closed'
      %(closed an issue #{format_issue(payload['issue'])})
    when 'assigned'
      %(assigned an issue #{payload.tiny_issue} to **#{payload['assignee']['login']}**
<#{payload['issue']['html_url']}>)
    when 'unassigned'
      %(unassigned an issue #{payload.tiny_issue} from **#{payload['assignee']['login']}**
<#{payload['issue']['html_url']}>)
    when 'labeled'
      %(added label `[#{payload['label']['name']}]` to an issue #{payload.tiny_issue}
<#{payload['issue']['html_url']}>)
    when 'unlabeled'
      %(removed label `[#{payload['label']['name']}]` from an issue #{payload.tiny_issue}
<#{payload['issue']['html_url']}>)
    end
  end
end
