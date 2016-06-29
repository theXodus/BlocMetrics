class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true
  validates :name, presence: true
  validates :url, url: true
end
