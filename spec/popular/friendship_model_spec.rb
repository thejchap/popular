shared_examples 'a friendship model' do

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
