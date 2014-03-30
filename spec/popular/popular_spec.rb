require 'spec_helper'

describe Popular::Popular do

  context 'popular user' do
    it 'is popular' do
      expect( PopularModel ).to be_popular
    end
  end

  context 'un-popular user' do
    it 'is not popular' do
      expect( UnpopularModel ).to_not be_popular
    end
  end

  it_behaves_like 'a popular model' do
    let ( :popular_model ) { PopularModel.create }
    let ( :another_popular_model ) { PopularModel.create }
  end

end
