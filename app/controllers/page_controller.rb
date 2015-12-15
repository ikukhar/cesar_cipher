class PageController < ApplicationController

  def index
  end

  def crypt
    type = params[:type]
    text = params[:text]
    offset = params[:offset].to_i

    render json: JSON.generate({
      text: Cipher.send(type, text, offset),
    })
  end

  def analyse_text
    text = params[:text]
    render json: JSON.generate({
      letter_freq: Cipher.frequency(text),
      guessed_offsets: Cipher.guess_offsets(text)
    })
  end

end
