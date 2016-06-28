module RubotHandlers::CommitComment
  def self.handle(payload)
    comment = payload['comment'];
    %(commented on a commit `#{comment['commit_id'][0..6]}`
<#{comment['html_url']}>

#{comment['body']})
  end
end
