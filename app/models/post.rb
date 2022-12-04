class Post < ActiveRecord::Base
    def with_keyword(with_keyword)
        with_keyword.downcase!
        if with_keyword.length != 0
            if ((self.description.downcase.include? with_keyword) or (self.item.downcase.include? with_keyword))
                return true
            end
            return false
        end
        return true
    end

    def with_price_range(min_price, max_price)
        # display as long as price or highest bid or start bid in the range
        if self.current_bid.to_f.between?(min_price, max_price)
            return true
        end
        if self.price.to_f.between?(min_price, max_price)
            return true            
        end
        if self.start_bid.to_f.between?(min_price, max_price)
            return true            
        end

        return false
    end

    def self.with_categories(categories_list)
        if categories_list.length != 0
            return Post.where(category: categories_list)
        end
    end

    def self.all_categories()
        @all_categories = ['Electronics','Bedding','Education']
    end
end
