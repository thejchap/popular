require "active_record"

# Namespace for classes and modules that handle friendship related tasks
#
# @author Justin Chapman
#
# @since 0.0.1
module Friendable

  if defined? ActiveRecord::Base
    require "friendable/extenders/friendable"

    # Extend ActiveRecord with extenders
    ActiveRecord::Base.extend Friendable::Extenders::Friendable
  end

end
