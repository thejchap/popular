shared_examples "a popular model" do

  describe '.befriend!' do
    it 'creates a one way friendship' do
      popular_model.befriend! another_popular_model

      expect( popular_model).to be_friends_with another_popular_model
    end

    it 'triggers before_befriend callback' do
      ensure_callback_fired_on popular_model_with_callbacks, :before_befriend_callback

      popular_model_with_callbacks.befriend! another_popular_model
    end

    context 'successful' do
      it 'triggers after_befriend callback' do
        ensure_callback_fired_on popular_model_with_callbacks, :after_befriend_callback

        popular_model_with_callbacks.befriend! another_popular_model
      end
    end
  end

  describe '.befriend' do

    context 'successful' do
      it 'triggers before_befriend callback' do
        ensure_callback_fired_on popular_model_with_callbacks, :before_befriend_callback

        popular_model_with_callbacks.befriend another_popular_model
      end

      it 'triggers after_befriend callback' do
        ensure_callback_fired_on popular_model_with_callbacks, :after_befriend_callback

        popular_model_with_callbacks.befriend another_popular_model
      end

      it 'creates a one way friendship' do
        popular_model.befriend another_popular_model

        expect( popular_model).to be_friends_with another_popular_model
      end
    end

  end

  describe '#friends_with?' do
    it 'returns true if a popular_model is friends with a given popular_model' do
      expect( popular_model ).to_not be_friends_with another_popular_model
    end

    it 'returns true if a popular_model is friends with a given popular_model' do
      popular_model.befriend another_popular_model

      expect( popular_model ).to be_friends_with another_popular_model
    end
  end

  describe '.unfriend' do
    it 'destroys a friendship' do
      [:befriend, :unfriend].each do |method|
        popular_model.send method, another_popular_model
      end

      expect( popular_model).to_not be_friends_with another_popular_model
    end

    it 'triggers before_unfriend callback' do
      ensure_callback_fired_on popular_model_with_callbacks, :before_unfriend_callback

      [:befriend, :unfriend].each do |method|
        popular_model_with_callbacks.send method, another_popular_model
      end
    end

    it 'triggers after_unfriend callback' do
      ensure_callback_fired_on popular_model_with_callbacks, :after_unfriend_callback

      [:befriend, :unfriend].each do |method|
        popular_model_with_callbacks.send method, another_popular_model
      end
    end
  end

  def ensure_callback_fired_on model, method
    model.send( :should_receive, method ).once.and_return true
  end
end
