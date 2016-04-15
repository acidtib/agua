# == Schema Information
#
# Table name: stories
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  story_id       :string
#  location_id    :integer
#  elevation      :integer
#  under          :integer
#  latitude       :string
#  longitude      :string
#  photo_original :string
#  photo_story    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
