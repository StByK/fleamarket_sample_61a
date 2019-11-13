class Category < ApplicationRecord
  has_many :items
  has_ancestry

  def self.c_category(parent)
    
    ch = []
    parent.each do |parent|
      parent.children.each do |child|
        ch << child
        
      end
    end
    return ch
  end

end