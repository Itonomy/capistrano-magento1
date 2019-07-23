##
# Copyright © 2019 by Itonomy B.V. All rights reserved
#
# Licensed under the MIT Licence (MIT)
# See included LICENSE file for full text of MIT
#
# https://itonomy.nl
##
namespace :magento do

  namespace :setup do
    desc 'Sets proper permissions on application'
    task :permissions do
      on release_roles :all do
        within release_path do
          execute :find, release_path, "-type d -exec chmod #{fetch(:magento_deploy_chmod_d).to_i} {} +"
          execute :find, release_path, "-type f -exec chmod #{fetch(:magento_deploy_chmod_f).to_i} {} +"
          execute :find, "#{release_path}/var", "-type f -exec chmod #{fetch(:magento_deploy_var_media_chmod_f).to_i} {} +"
          execute :find, "#{release_path}/media", "-type f -exec chmod #{fetch(:magento_deploy_var_media_chmod_f).to_i} {} +"
          execute :find, "#{release_path}/var", "-type d -exec chmod #{fetch(:magento_deploy_var_media_chmod_d).to_i} {} +"
          execute :find, "#{release_path}/media", "-type d -exec chmod #{fetch(:magento_deploy_var_media_chmod_d).to_i} {} +"
        end
      end
      Rake::Task['magento:setup:permissions'].reenable  ## make task perpetually callable
    end

    task :clean do
      desc "Remove files after release"
      on release_roles :all do
        within release_path do
          for file in fetch(:magento_deploy_cleanup_files) do
            execute :rm, "-rf", "#{release_path}/#{file}"
          end
        end
      end
    end
  end

  namespace :cache do

      desc "Clear the Magento Cache"
      task :clear do
        on release_roles :all do
          within release_path do
            execute :php, "-r", "\"require_once('app/Mage.php'); Mage::app()->cleanCache(); \""
          end
        end
      end

      desc "Flush the Magento Cache Storage"
      task :flush do
        on release_roles :all do
          within release_path do
            execute :php, "-r", "\"require_once('app/Mage.php'); Mage::dispatchEvent('adminhtml_cache_flush_all'); Mage::app()->getCacheInstance()->flush(); \""
          end
        end
      end

      desc "Clean Merged Js Css"
      task :clean_merged_js_css do
        on release_roles :all do
          within release_path do
            execute :php, "-r", "\"require_once('app/Mage.php'); Mage::app()->setCurrentStore(Mage_Core_Model_App::ADMIN_STORE_ID); Mage::getModel('core/design_package')->cleanMergedJsCss();  Mage::dispatchEvent('clean_media_cache_after'); \""
          end
        end
      end

      desc "Clean the Magento external Page Cache"
      task :clean_page_cache do
        on release_roles :all do
          within release_path do
            execute :php, "-r", "\"require_once('app/Mage.php'); Mage::app()->setCurrentStore(Mage_Core_Model_App::ADMIN_STORE_ID); if (Mage::helper('pagecache')->isEnabled()) { Mage::helper('pagecache')->getCacheControlInstance()->clean(); } \""
          end
        end
      end

  end

  namespace :maintenance do
    desc "Turn on maintenance mode by creating maintenance.flag file"
    task :enable do
      on release_roles :all do
        within release_path  do
          execute :touch, "#{release_path}/maintenance.flag"
        end
      end
    end

    desc "Turn off maintenance mode by removing maintenance.flag file"
    task :disable do
      on release_roles :all do
        within release_path  do
          execute :rm, "-f", "#{release_path}/maintenance.flag"
        end
      end
    end
  end

  namespace :compiler do
    desc "Run compilation process and enable compiler include path"
    task :compile do
      on release_roles :all do
        within release_path.join('shell') do
          execute :php, "-f", "compiler.php", "--", "compile"
        end
      end
    end

    desc "Enable compiler include path"
    task :enable do
      on release_roles :all do
        within release_path.join('shell') do
          execute :php, "-f", "compiler.php", "--", "enable"
        end
      end
    end

    desc "Disable compiler include path"
    task :disable do
      on release_roles :all do
        within release_path.join('shell') do
          execute :php, "-f", "compiler.php", "--", "disable"
        end
      end
    end

    desc "Disable compiler include path and remove compiled files"
    task :clear do
      on release_roles :all do
        within release_path.join('shell') do
          execute :php, "-f", "compiler.php", "--", "clear"
        end
      end
    end
  end

  namespace :indexer do
    desc "Reindex data by all indexers"
    task :reindexall do
      on release_roles :all do
        within release_path.join('shell') do
          execute :php, "-f", "indexer.php", "--", "reindexall"
        end
      end
    end
  end

  namespace :logs do
    desc "Clean logs"
    task :clean do
      on release_roles :all do
        within release_path.join('shell') do
          execute :php, "-f", "log.php", "--", "clean"
        end
      end
    end
  end
end
