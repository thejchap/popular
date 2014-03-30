shared_examples "a popular model" do

  describe 'mutual friendships' do
    it '.inverse_friends includes popular_models who have added an instance as a friend' do
      another_popular_model.befriend popular_model

      expect( popular_model ).to be_friended_by another_popular_model
    end

    it '#mutual_friends_with? returns false if instances are not mutual friends' do
      expect( popular_model ).to_not be_mutual_friends_with another_popular_model
    end

    it '#mutual_friends_with? returns true if instances have befriended eachother' do
      popular_model.befriend another_popular_model
      another_popular_model.befriend popular_model

      expect( popular_model ).to be_mutual_friends_with another_popular_model
    end
  end

  describe '.befriend!' do
    it 'can be called with .follow!' do
      popular_model.follow! another_popular_model

      expect( popular_model).to be_following another_popular_model
    end

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
    it 'can be called with .follow' do
      popular_model.follow another_popular_model

      expect( popular_model).to be_following another_popular_model
    end


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
