class RegisteredApplication < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: {minimum: 3}
  validates :url, presence: true, length: {minimum: 10}, uniqueness: true, format: { with: /\A(https?:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w$%=?#\.-]*)\z/ }
end
