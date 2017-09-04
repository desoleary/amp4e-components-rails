module Amp4e
  module Components
    module Rails
      if defined? ::Rails::Engine
        class Engine < ::Rails::Engine
        end
      end
    end
  end
end