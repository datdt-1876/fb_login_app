class StaticPagesController < ApplicationController
  def home

    #GET APP ACCESS TOKEN
    para = {
      client_id: "722015788192767",
      client_secret: "b4ecae453464cdf97f482da41590db9e",
      grant_type: "client_credentials"
    }
    uri = URI('https://graph.facebook.com/oauth/access_token')
    uri.query = URI.encode_www_form(para)
    res = Net::HTTP.get_response(uri)
    data = JSON.parse res.body

    session[:app_access_token] = data["access_token"]



    #GET APP INFO
    para = {
      access_token: data["access_token"],
      fields: "id,app_domains,app_name,category,photo_url"
    }
    uri = URI('https://graph.facebook.com/722015788192767')
    uri.query = URI.encode_www_form(para)
    res = Net::HTTP.get_response(uri)
    @data = JSON.parse res.body

    puts @data
  end
end
