##
# Copyright © 2019 by Itonomy B.V. All rights reserved
#
# Licensed under the MIT Licence (MIT)
# See included LICENSE file for full text of MIT
#
# https://itonomy.nl
##

load File.expand_path('../tasks/magento.rake', __FILE__)

namespace :load do
  task :defaults do
    load 'capistrano/magento/defaults.rb'
  end
end