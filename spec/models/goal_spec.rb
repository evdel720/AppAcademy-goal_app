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

require 'rails_helper'

RSpec.describe Goal, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:details) }
  it { should validate_inclusion_of(:completed).in_array([true, false])}
  it { should validate_inclusion_of(:goal_private).in_array([true, false])}

end
