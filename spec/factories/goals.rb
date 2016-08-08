# == Schema Information
#
# Table name: goals
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  title        :string           not null
#  details      :text             not null
#  goal_private :boolean          default(FALSE), not null
#  completed    :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    sequence :user do |n|
      FactoryGirl.build(:user, username: "username", password: "123456")
    end
    title "My goal"
    details "goal details"
    goal_private false
    completed false
  end
end
