# frozen_string_literal: true

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  post '/posts' do
    initialize_post
    @post.save
    post_creation_response(@post)
  rescue Sequel::ValidationFailed => e
    message = @post.errors.empty? ? e.message : @post.errors
    build_ue_response(message)
  rescue Sequel::ForeignKeyConstraintViolation => e
    build_ue_response(e.message)
  end

  get '/posts/average_top_rated/:n' do |n|
    posts = Post.order(Sequel.desc(:average_rating)).first(n.to_i)
    average_top_rated_n_posts(posts)
  rescue Sequel::Error => e
    build_ue_response(e.message)
  end

  def json_params
    JSON.parse(request.body.read)
  rescue JSON::ParserError => e
    build_ue_response(e.message)
  end
end

def average_top_rated_n_posts(posts)
  json_array = posts.map { |post| PostSerializer.new(post).to_json }
  data = {
    posts: json_array
  }

  build_ok_response(data)
end

def post_creation_response(post)
  data = {
    post: PostSerializer.new(post).to_json
  }

  build_ok_response(data)
end

def initialize_post
  params = json_params.slice('title', 'content', 'auther')
  auther_params = params.delete('auther')
  @post = Post.new(params)
  auther = User.find_or_create(username: auther_params.delete('username'))
  @post.ip_address_attributes = auther_params
  @post.user = auther
end
