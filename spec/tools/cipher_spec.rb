RSpec.describe "cipher tool" do

  it "encrypts english text" do
    text = "The above example uses only standard Rails and RSpec APIs"
    offset = 5
    result = "Ymj fgtAj jCfruqj zxjx tsqD xyfsifwi Wfnqx fsi WXujh FUNx"
    expect(Cipher.encrypt(text, offset)).to eq(result)
  end

  it "encrypts english text" do
    text = "Ymj fgtAj jCfruqj zxjx tsqD xyfsifwi Wfnqx fsi WXujh FUNx"
    offset = 5
    result = "The above example uses only standard Rails and RSpec APIs"
    expect(Cipher.decrypt(text, offset)).to eq(result)
  end
  
end
