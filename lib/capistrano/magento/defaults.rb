##
# Copyright © 2019 by Itonomy B.V. All rights reserved
#
# Licensed under the MIT Licence (MIT)
# See included LICENSE file for full text of MIT
#
# https://itonomy.nl
##

set :linked_dirs, fetch(:linked_dirs, []).push(
    "var",
    "media",
    "sitemaps"
)

set :linked_files, fetch(:linked_files, []).push(
    "app/etc/local.xml"
)

# deploy configuration defaults
set :magento_roles, fetch(:magento_deploy_setup_role, :all)
set :magento_deploy_confirm, fetch(:magento_deploy_confirm, [])
set :magento_deploy_maintenance, fetch(:magento_deploy_maintenance, true)

# deploy permissions defaults
set :magento_deploy_chmod_d, fetch(:magento_deploy_chmod_d, '0740')
set :magento_deploy_chmod_f, fetch(:magento_deploy_chmod_f, '0640')
set :magento_deploy_var_media_chmod_d, fetch(:magento_deploy_var_media_chmod_d, '0740')
set :magento_deploy_var_media_chmod_f, fetch(:magento_deploy_var_media_chmod_f, '0640')

# file cleanup
set :magento_deploy_cleanup, fetch(:magento_deploy_cleanup, true)
set :magento_deploy_cleanup_files, fetch(:magento_deploy_cleanup_files, []).push(
    "config",
    "Capfile",
    "Gemfile",
    "Gemfile.lock"
)