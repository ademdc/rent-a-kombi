class Api::V1::ApplicationController < ::ApplicationController
  include Api::V1::Concerns::Authorization

  protect_from_forgery with: :null_session
end
