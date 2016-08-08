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

class Goal < ActiveRecord::Base
  validates :title, :user, :details, presence: true
  belongs_to :user
  validates :goal_private, :completed, inclusion: [true, false]

end
