require "rails_helper"

describe PageController do

  describe "GET #index" do
    it "renders the index" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #crypt" do
    it "returns success json" do
      get :crypt, text: "Some text", offset: 1, type: 'encrypt'
      expect(response.body).to have_json_path("text")
    end
  end

  describe "GET #analyse_text" do
    it "returns success json" do
      get :analyse_text, text: "Some text"
      expect(response.body).to have_json_path("letter_freq")
      expect(response.body).to have_json_path("guessed_offsets")
    end
  end

end
