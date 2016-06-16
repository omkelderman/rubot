# frozen_string_literal: true

module RubotHandlers::Push
  def self.format_commit(commit)
    sha = "`#{commit['id'][0..6]}` "
    message = commit['message'].lines[0].strip
    author = " [#{commit['author']['username']}]"
    sha + message + author
  end

  def self.handle(payload)
    if payload['commits'].length > 0
      _, type, *name = payload['ref'].split('/')
      name = name.join('/')
      case type
      when 'heads' # branch
        str = "pushed **#{payload['commits'].length}** commit#{payload['commits'].length == 1 ? '' : 's'} to a branch **#{name}**\n"
        str += payload['commits'].map { |e| format_commit(e) }.join("\n")
        str
      end
    else
      nil
    end
  end
end
