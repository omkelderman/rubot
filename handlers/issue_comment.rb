module RubotHandlers::IssueComment
  def self.handle(payload)
    %(commented on issue #{payload.tiny_issue}
<#{payload['comment']['html_url']}>
```
#{payload['comment']['body']}
```)
  end
end
