shared_examples 'a friendship model' do

  describe 'custom data' do
    it 'allows for a one-to-one mapping between friendship and a friendship_profile' do
      friendship = custom_popular_model.befriend another_custom_popular_model

      expect( friendship.friendship_profile ).to_not be_nil
    end

    it 'model does not get created unless explicitly opted in' do
      friendship = popular_model.befriend another_popular_model

      expect( friendship.friendship_profile ).to be_nil
    end
  end

  it 'ensures the friend is not the same as the popular_model' do
    invalid_model = described_class.new(
      friend: popular_model,
      popular_model: popular_model
    )

    expect( invalid_model ).to_not be_valid
  end

  it 'validates presence of popular_model' do
    invalid_model = described_class.new friend: popular_model

    expect( invalid_model ).to_not be_valid
  end

  it 'validates presence of friend' do
    invalid_model = described_class.new popular_model: popular_model

    expect( invalid_model ).to_not be_valid
  end

end
