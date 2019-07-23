##
# Copyright © 2019 by Itonomy B.V. All rights reserved
#
# Licensed under the MIT Licence (MIT)
# See included LICENSE file for full text of MIT
#
# https://itonomy.nl
##

require 'terminal-notifier'

namespace :deploy do
  after 'deploy:failed', :notify_user_failure do
    run_locally do
      set :message, "ERROR in deploying " + fetch(:application).to_s + " to " + fetch(:stage).to_s
      TerminalNotifier.notify(fetch(:message), :title => 'Capistrano')
    end
  end

  after :finished, :notify_user do
    run_locally do
      set :message, "Finished deploying " + fetch(:application).to_s + " to " + fetch(:stage).to_s
      TerminalNotifier.notify(fetch(:message), :title => 'Capistrano')
    end
  end
end
