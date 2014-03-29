require 'spec_helper'

describe Friendly::Friendly do

  context 'friendly user' do
    it 'is friendly' do
      expect( FriendlyUser ).to be_friendly
    end
  end

  context 'unfriendable user' do
    it 'is not friendable' do
      expect( UnfriendlyUser ).to_not be_friendly
    end
  end

end
