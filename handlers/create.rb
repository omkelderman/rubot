# frozen_string_literal: true

module RubotHandlers::Create
  def self.handle(payload)
    "created a #{payload['ref_type']} `#{payload['ref']}`"
  end
end
