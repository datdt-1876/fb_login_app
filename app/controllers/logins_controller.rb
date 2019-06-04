require 'net/http'
class LoginsController < ApplicationController
  def create
    
  end

  def new
  end

  def show
    uri = URI('https://graph.facebook.com/v3.3/oauth/access_token')
    para = {
      client_id: "722015788192767",
      redirect_uri: "http://localhost:3000/login",
      client_secret: "b4ecae453464cdf97f482da41590db9e",
      code: params[:code]
    }
    uri.query = URI.encode_www_form(para)
    res = Net::HTTP.get_response(uri)

    data = JSON.parse res.body
    puts data
    puts "Successfully connected"
    session[:access_token] = data["access_token"]
    puts data["access_token"]
    
    uri = URI('https://graph.facebook.com/720999084982695')
    para = {
      fields: "access_token",
      access_token: data["access_token"]
    }
    uri.query = URI.encode_www_form(para)
    res = Net::HTTP.get_response(uri)

    data = JSON.parse res.body
    puts data
    session[:page_access_token] = data["access_token"]
    puts data["access_token"]

    redirect_to posts_path
  end
end

