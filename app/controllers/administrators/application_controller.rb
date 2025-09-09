class Administrators::ApplicationController < ApplicationController
  before_action :authenticate_administrator!
  layout 'administrators'
end
