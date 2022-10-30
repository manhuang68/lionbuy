class Post < ActiveRecord::Base
    def self.with_categories(categories_list)
        if categories_list.length != 0
          return Post.where(category:categories_list)   
        else
          return Post.all 
        end
    end
    
    def self.all_categories()
        @all_categories = ['Electronics','Bedding','Education']
    end 
end
