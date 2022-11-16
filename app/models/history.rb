class History < ActiveRecord::Base
    # Classical get method
    def seller
        @seller
    end

    def buyer
        @buyer
    end
    
    def item
        @item
    end
    
    # Classical set method
    def seller=(seller)
        @seller = seller
    end

    def buyer=(buyer)
        @buyer = buyer
    end

    def item=(item)
        @item = item
    end
end
