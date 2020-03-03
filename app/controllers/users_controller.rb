class UsersController < ApplicationController
  def index
    render(json: { message: 'List of Users.', news_items: User.all.as_json(only: %i[login full_name signature]) })
  end
end
