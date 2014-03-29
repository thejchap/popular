require 'spec_helper'

describe Friendable::Friendable do
  context 'friendable user' do
    it 'is friendable' do
      expect( FriendableUser ).to be_friendable
    end
  end

  context 'unfriendable user' do
    it 'is not friendable' do
      expect( UnfriendableUser ).to_not be_friendable
    end
  end
end
