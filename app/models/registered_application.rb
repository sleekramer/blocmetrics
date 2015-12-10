class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events

  validates :name, presence: true, length: {minimum: 3}
  validates :url, presence: true, length: {minimum: 10}, uniqueness: true, format: { with: /\A(https?:\/\/)([\da-z\.-]+)(\.[a-z\.]{2,6}|:\d{2,4})([\/\w$%=?#\.-]*)\z/ }
end
