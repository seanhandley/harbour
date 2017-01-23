class User < ApplicationRecord
  belongs_to :organization
  has_many :api_credentials
  has_many :user_project_roles, dependent: :destroy
  has_many :projects, -> { distinct }, :through => :user_project_roles
  has_secure_password

  after_initialize :generate_uuid

  validates :email, :uniqueness => true
  validates :email, :organization_id, :presence => true
  validates :password, :presence => true, :on => :create

  private

  def generate_uuid
    if self.new_record? && valid?
      self.uuid = SecureRandom.hex unless self.uuid
    end
  end
end