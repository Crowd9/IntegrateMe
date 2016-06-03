module App
  class WelcomeController < BaseController
    def index
      @competitions = Competition.all.order('created_at desc')
    end
  end
end
