require 'spec_helper'

describe Popular::Friendship do

  it_behaves_like 'a friendship model' do
    let ( :popular_model ) { PopularModel.create }
    let ( :another_popular_model ) { PopularModel.create }
    let ( :custom_popular_model ) { CustomPopularModel.create }
    let ( :another_custom_popular_model ) { CustomPopularModel.create }
  end

end
