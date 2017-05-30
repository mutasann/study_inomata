class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # validates_presence_of :username
  # validates_uniqueness_of :username, case_sensitive: false
  # def to_param
  #   username
  # end
end
