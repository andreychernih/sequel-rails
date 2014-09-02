require 'generators/sequel'

module Sequel
  module Generators
    class ModelGenerator < Base
      argument :attributes, :type => :array, :default => [], :banner => 'field:type field:type'

      check_class_collision

      class_option :migration,  :type => :boolean
      class_option :timestamps, :type => :boolean
      class_option :parent,     :type => :string, :desc => 'The parent class for the generated model'

      def create_migration_file
        file_path = SequelRails.configuration.migrations_dir.join("create_#{table_name}.rb")
        migration_template('migration.rb.erb',file_path) if options[:migration]
      end

      def create_model_file
        template(
          'model.rb.erb',
          File.join('app', 'models', class_path, "#{file_name}.rb")
        )
      end

      hook_for :test_framework
    end
  end
end
