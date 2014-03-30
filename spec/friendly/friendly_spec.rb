require 'spec_helper'

describe Friendly::Friendly do

  context 'friendly user' do
    it 'is friendly' do
      expect( FriendlyModel ).to be_friendly
    end
  end

  context 'unfriendable user' do
    it 'is not friendable' do
      expect( UnfriendlyModel ).to_not be_friendly
    end
  end

  it_behaves_like 'a friendly model' do
    let ( :friendly_model ) { FriendlyModel.create }
    let ( :another_friendly_model ) { FriendlyModel.create }
  end

end
