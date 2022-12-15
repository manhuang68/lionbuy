class Post < ActiveRecord::Base
  #has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>", large: "500x500>"}, default_url: "/images/:style/missing.png"
  #validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
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

    def self.get_only_id(list)
      tmp = []
      list.each do |data|
        puts data.id
        tmp.append(data.id)
      end
      puts "the id are"
      puts tmp
      return tmp
    end
end
