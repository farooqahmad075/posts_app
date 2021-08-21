# frozen_string_literal: true

class PostSerializer
  def initialize(post)
    @post = post
  end

  def to_json(*)
    {
      title: @post.title,
      content: @post.content
    }
  end
end
