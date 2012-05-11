require "pg-app-name/version"
require 'active_record'
module PG
  module ApplicationName
    def self.included(base)
      unless base.respond_to? :establish_connection_with_application_name
          base.extend ClassMethods
          base.class_eval do
            class << self
              alias_method_chain :establish_connection, :application_name
            end
          end
      end
    end

    module ClassMethods
      def establish_connection_with_application_name(*args)
        result = establish_connection_without_application_name(*args)
        appname = ENV['PG_APP_NAME'] || "ruby"
        appname = "#{appname}_without_pool"
        ::ActiveRecord::Base.connection.execute("set application_name = '#{appname}';")
        result
      end
    end
  end

  module PoolApplicationName
    def self.included(base)
      unless base.respond_to? :new_connection_with_application_name
        base.class_eval do
          include InstanceMethods
          alias_method_chain :new_connection, :application_name
        end
      end
    end

    module InstanceMethods
      def new_connection_with_application_name(*args)
        result = new_connection_without_application_name(*args)
        appname = ENV['PG_APP_NAME'] || "ruby"
        @pool_number ||= 1
        appname = "#{appname}_with_pool_#{@pool_number}"
        result.execute("set application_name = '#{appname}';")
        @pool_number = @pool_number + 1
        result
      end
    end
  end
end

class ActiveRecord::Base
  include PG::ApplicationName
end

class ActiveRecord::ConnectionAdapters::ConnectionPool
  include PG::PoolApplicationName
end

if defined?(RAILS)
  ENV['PG_APP_NAME'] ||= Rails.application.class.name.split('::')[0].tableize rescue 'rails'
end
