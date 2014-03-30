class PopularModelWithCallbacks < PopularModel
  [:after, :before].each do |filter|
    [:befriend, :unfriend].each do |action|
      hook = "#{filter}_#{action}".to_sym
      method_name = "#{hook}_callback".to_sym

      send hook, method_name

      define_method method_name do
        true
      end
    end
  end
end
