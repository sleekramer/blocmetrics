class Event < ActiveRecord::Base
  belongs_to :registered_application

  validates :name, presence: true, length: {minimum: 1}
end
