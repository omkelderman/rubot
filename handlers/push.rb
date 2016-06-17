# frozen_string_literal: true
require 'net/http'

module RubotHandlers::Push
  def self.format_commit(commit)
    sha = "`#{commit['id'][0..6]}` "
    message = commit['message'].lines[0].strip
    author = " [#{commit['author']['username']}]"

    uri = URI('https://git.io')
    response = Net::HTTP.post_form(uri, {url: commit['url']})
    url = if response['Location']
      response['Location']
    else
      commit['url']
    end

    url = " (<#{url}>)"
    sha + message + author + url
  end

  def self.handle(payload)
    if payload['commits'].length > 0
      _, type, *name = payload['ref'].split('/')
      name = name.join('/')
      case type
      when 'heads' # branch
        str = "pushed **#{payload['commits'].length}** commit#{payload['commits'].length == 1 ? '' : 's'} to a branch **#{name}**\n"
        str += "<#{payload['compare']}>\n"
        str += payload['commits'].map { |e| format_commit(e) }.join("\n")
        str
      end
    else
      nil
    end
  end
end
