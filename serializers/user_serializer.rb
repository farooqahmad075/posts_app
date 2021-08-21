# frozen_string_literal: true

class UserSerializer
  def initialize(user)
    @user = user
  end

  def to_json(*)
    {
      username: @user.username
    }
  end
end
