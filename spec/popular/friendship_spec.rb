require 'spec_helper'

describe Popular::Friendship do

  it_behaves_like 'a friendship model' do
    let ( :popular_model ) { PopularModel.create }
    let ( :another_popular_model ) { PopularModel.create }
  end

end
