shared_examples "a friendly model" do

  describe '.befriend' do
    it 'creates a one way friendship' do
      friendly_model.befriend another_friendly_model

      expect( friendly_model.friends ).to match_array [another_friendly_model]
    end
  end

  describe '.unfriend' do
    it 'destroys a friendship' do
      [:befriend, :unfriend].each do |method|
        friendly_model.send method, another_friendly_model
      end

      expect( friendly_model.friends ).to be_empty
    end
  end

end
