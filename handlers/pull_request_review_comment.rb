module RubotHandlers::PullRequestReviewComment
  def self.handle(payload)
    action = case payload['action']
    when 'created'
      'commented'
    when 'edited'
      'edited a comment'
    when 'deleted'
      'deleted a comment'
    end

    %(#{action} on a pull request #{payload.tiny_pull_request}
<#{payload['comment']['html_url']}>
```
#{payload['comment']['body']}
```)
  end
end
