class UrlController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  include UrlHelper
  def index
  end

  def shortenUrl
    shortUrl = generate_shorten_url(10)
    url = Url.new(originUrl: params['originUrl'], shortPath: shortUrl)
    url.save
    render json: {
      success: true,
      data: {
        shortPath: shortUrl
      }
    }
  end

  def parseUrl
    shortPath = params['shortPath']
    puts ("--- #{shortPath}")
    url = Url.find_by(shortPath: shortPath)
    puts url.inspect
    redirect_to url.originUrl, allow_other_host: true
  end
end
