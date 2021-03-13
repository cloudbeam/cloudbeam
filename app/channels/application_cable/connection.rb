module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      id = cookies.signed[:user_id]
      if id then
        self.current_user = User.find(id)
      end
    end
  end
end
