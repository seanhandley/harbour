class UserSerializer < ActiveModel::Serializer
  attributes :uuid, :email, :first_name, :last_name
  has_and_belongs_to_many :projects
end