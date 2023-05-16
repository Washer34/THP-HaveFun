class Attendance < ApplicationRecord
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'
  belongs_to :event
end
