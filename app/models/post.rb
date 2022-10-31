class Post < ActiveRecord::Base
    def with_keyword(with_keyword)
        if with_keyword.length != 0
            if (self.description.downcase.include? with_keyword)
                return true
            elsif (self.item.downcase.include? with_keyword)
                return true
            end
            return false
        end
        return true
    end

    def self.with_categories(categories_list)
        if categories_list.length != 0
            return Post.where(category: categories_list) 
        else
            return Post.all 
        end
    end

    def self.all_categories()
        @all_categories = ['Electronics','Bedding','Education']
    end 
end
