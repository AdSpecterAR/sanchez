class TestsController < ApplicationController

  def index
    render json: { image_url: "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png"}
  end

end
