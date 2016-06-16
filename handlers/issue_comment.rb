module RubotHandlers::IssueComment
  def self.handle(payload)
    url = payload['issue']['html_url'].split('/')

    type = case url[-2]
    when 'issues'
      'an issue'
    when 'pull'
      'a pull request'
    end

    action = case payload.action
    when 'created'
      'commented'
    when 'edited'
      'edited a comment'
    when 'deleted'
      'deleted a comment'
    end

    %(#{action} on #{type} #{payload.tiny_issue}
<#{payload['comment']['html_url']}>
```
#{payload['comment']['body']}
```)
  end
end
