class SellHistory < ActiveRecord::Base
    def buyer
        @buyer
    end

    def item
        @item
    end
    # Classical set method
    def buyer=(buyer)
        @buyer = buyer
    end

    def item=(item)
        @item = item
    end
end
