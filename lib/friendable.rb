require "active_record"

module Friendable

  if defined? ActiveRecord::Base
    require "friendable/extenders/friendable"

    ActiveRecord::Base.extend Friendable::Extenders::Friendable
  end

end
