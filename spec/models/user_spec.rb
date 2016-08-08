# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe 'uniqueness' do
    FactoryGirl.create(:user)
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end

  let(:user) { FactoryGirl.build(:user) }

  describe '#password=' do
    it 'generates password_digest' do
      expect(user.password_digest).not_to be(nil)
    end
  end

  describe '#is_password?' do
    it 'verifies the password' do
      expect(user.is_password?('123456')).to be(true)
      expect(user.is_password?('dsfdff')).to be(false)
    end
  end

  describe '#reset_session_token' do
    it 'resets the user\'s session token' do
      current_session_token = user.session_token
      user.reset_session_token
      expect(user.session_token).not_to eq(current_session_token)
    end
  end

  describe '::find_by_credentials' do
    new_user = User.create(username: Faker::Name.name, password: '123456')

    it 'finds the user with valid credentials' do
      result = User.find_by_credentials(new_user.username, '123456')
      expect(result).to eq(new_user)
    end

    it 'returns nil with invalid credentials' do
      result = User.find_by_credentials('second_user', '123456')
      expect(result).to be(nil)
    end
  end
end
