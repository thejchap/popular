require "active_record"

# Namespace for classes and modules that handle friendship related tasks
#
# @author Justin Chapman
#
# @since 0.0.1
module Friendly

  if defined? ActiveRecord::Base
    require "friendly/extenders/friendly"

    # Extend ActiveRecord with extenders
    ActiveRecord::Base.extend Friendly::Extenders::Friendly
  end

end
