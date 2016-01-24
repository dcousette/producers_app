require 'rails_helper'

describe Song do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  # it { should validate_presence_of(:song_file) }    need to test this too!!
  # it { should validate_uniqueness_of(:song_file) }
end
