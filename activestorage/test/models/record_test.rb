# frozen_string_literal: true

require "test_helper"
require "database/setup"

class ActiveStorage::RecordTest < ActiveSupport::TestCase
  setup do
    @old_prefix = ActiveRecord::Base.table_name_prefix
    @old_suffix = ActiveRecord::Base.table_name_suffix

    ActiveRecord::Base.table_name_prefix = @prefix = "prefix_"
    ActiveRecord::Base.table_name_suffix = @suffix = "_suffix"

    @descendants = ActiveStorage::Record.descendants
    @descendants.map(&:reset_table_name)
  end

  test "prefix and suffix are added to the ActiveStorage tables' name" do
    ActiveStorage::Record.descendants.each do |model|
      undecorated_table_name = model.send(:undecorated_table_name, model.model_name)

      assert_equal "#{@prefix}active_storage_#{undecorated_table_name}#{@suffix}", model.table_name
    end
  ensure
    ActiveRecord::Base.table_name_prefix = @old_prefix
    ActiveRecord::Base.table_name_suffix = @old_suffix
    @descendants.map(&:reset_table_name)
  end
end
