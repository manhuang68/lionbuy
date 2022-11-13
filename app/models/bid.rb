class Bid < ActiveRecord::Base
  def self.sorting(product_id)
    tmp = []
    self.all.each do |data|
      puts data.product_id+ " " + product_id
      if data.product_id == product_id
        tmp.append(data)
      end
    end
    puts "we are"
    tmp = tmp.sort_by { |h| h[:bid] }.reverse
    return tmp
  end
end
