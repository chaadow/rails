# frozen_string_literal: true

class ActiveStorage::Record < ActiveRecord::Base # :nodoc:
  self.abstract_class = true

  def self.full_table_name_prefix
    table_name_prefix.to_s + super
  end
end

ActiveSupport.run_load_hooks :active_storage_record, ActiveStorage::Record
