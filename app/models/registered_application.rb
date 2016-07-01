class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events
  before_validation :smart_add_url_protocol
  validates :url, presence: true
  validates :name, presence: true


  protected

  def smart_add_url_protocol
    unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
      self.url = "http://#{self.url}"
    end
  end
end
