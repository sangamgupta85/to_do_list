class Todo < ActiveRecord::Base
  attr_accessible :description, :done
  
  def self.find_not_done
    Todo.find(:all, :conditions => {:done => '0'})
  end

  def self.find_done
   Todo.find(:all, :conditions => {:done => '1'})
  end
  
end
