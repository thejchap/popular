shared_examples "a friendly model" do

  describe '.befriend' do
    it 'creates a one way friendship' do
      friendly_model.befriend another_friendly_model

      expect( friendly_model.friends ).to match_array [another_friendly_model]
    end
  end

end
