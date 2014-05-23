require 'generators/sequel'

module Sequel
  class IllegalMigrationNameError < StandardError
    def initialize(name)
      super("Illegal name for migration file: #{name} (only lower case letters, numbers, and '_' allowed)")
    end
  end

  module Generators
    class SessionMigrationGenerator < Base #:nodoc:
      argument :name, :type => :string, :default => 'add_sessions_table'

      def create_migration_file
        validate_file_name!
        file_path = SequelRails.configuration.migrations_dir.join("#{file_name}.rb")
        migration_template 'migration.rb.erb', file_path
      end

      protected

      def session_table_name
        ActionDispatch::Session::SequelStore.session_class.table_name
      end

      def validate_file_name!
        fail IllegalMigrationNameError file_name unless file_name =~ /^[_a-z0-9]+$/
      end
    end
  end
end
