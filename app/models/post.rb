class Post < ActiveRecord::Base
    def with_keyword(with_keyword)
        with_keyword.downcase!
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

    def with_price_range(min_price, max_price)
        min_price = min_price.to_f
        max_price = max_price.to_f
        if max_price == 0
            max_price = Float::MAX 
        end
       
        if self.price.to_f.between?(min_price, max_price)
            return true
        else 
            return false
        end
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
