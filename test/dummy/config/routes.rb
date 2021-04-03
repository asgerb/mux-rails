# frozen_string_literal: true

Rails.application.routes.draw do
  mount Mux::Engine => "/mux-rails"
end
