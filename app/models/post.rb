class Post < ApplicationRecord
  validates :title,uniqueness: true,presence:true
  validates :start,presence:true
  validates :finish,presence:true
  validates :memo,length: { maximum:150 }

  validate :strat_finish_check

  private
  require "date"

   def strat_finish_check
    if finish.nil? || Date.today.nil? || start.nil? || finish < start || finish < Date.today
      errors.add(:finish,"は開始日より以前の日付は選択出来ません。")
     end
   end


end
