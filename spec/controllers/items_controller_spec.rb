require 'rails_helper'

describe ItemsController do

  describe 'GET #show' do
    it "renders the :show template" do
      user = create(:user)
      item = create(:item)
      get :show, params: { id: 1 }
      expect(response).to render_template :show
    end
  end

end