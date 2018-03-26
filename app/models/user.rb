# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  email                        :string           default(""), not null
#  encrypted_password           :string           default(""), not null
#  reset_password_token         :string
#  reset_password_sent_at       :datetime
#  remember_created_at          :datetime
#  sign_in_count                :integer          default(0), not null
#  current_sign_in_at           :datetime
#  last_sign_in_at              :datetime
#  current_sign_in_ip           :inet
#  last_sign_in_ip              :inet
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  first_name                   :string
#  last_name                    :string
#  date_of_birth                :datetime
#  profile_picture_file_name    :string
#  profile_picture_content_type :string
#  profile_picture_file_size    :integer
#  profile_picture_updated_at   :datetime
#  sightings_count              :integer          default(0)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_sightings_count       (sightings_count)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :profile_picture,
   styles: { medium: '300x300>', thumb: '100x100>' },
   default_url: '/images/:style/missing.png'
  validates_attachment_content_type :profile_picture,
   content_type: /\Aimage\/.*\z/

  has_many :sightings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true

  def to_jwt
    # generate a json web token for user
    ::JsonWebToken.encode(user_id: id)
  end

  def full_name
    [first_name, last_name].join(' ')
  end
end
