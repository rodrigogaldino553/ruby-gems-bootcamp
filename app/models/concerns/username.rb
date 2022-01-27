module Username
  extend ActiveSupport::Concern

  included do
    puts '=================Hello world!======================'
  end

  def to_username(user_email)

  end
end