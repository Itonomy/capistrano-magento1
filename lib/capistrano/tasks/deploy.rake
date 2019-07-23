##
# Copyright © 2019 by Itonomy B.V. All rights reserved
#
# Licensed under the MIT Licence (MIT)
# See included LICENSE file for full text of MIT
#
# https://itonomy.nl
##

namespace :deploy do
  before :starting, :confirm_action do
    if fetch(:magento_deploy_confirm).include? fetch(:stage).to_s
      print "\e[0;31m      Are you sure you want to deploy to #{fetch(:stage).to_s}? [y/n] \e[0m"
      proceed = STDIN.gets[0..0] rescue nil
      exit unless proceed == 'y' || proceed == 'Y'
    end
  end

  task :updated do
    invoke 'magento:setup:permissions'
    invoke 'magento:maintenance:enable' if fetch(:magento_deploy_maintenance)
  end

  task :published do
    invoke 'magento:cache:flush'
    invoke 'magento:setup:permissions'
    invoke 'magento:maintenance:disable' if fetch(:magento_deploy_maintenance)
    invoke 'magento:setup:clean' if fetch(:magento_deploy_cleanup)
  end
end
