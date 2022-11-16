require 'rails_helper'

RSpec.describe History, type: :model do
    #  pending "add some examples to (or delete) #{__FILE__}"

    # for coverage
    describe 'Getter' do
        it "Open a history" do
            h = History.create({:product_id => 1,  :buyer_id => 2, :price => "800"})

            h.seller
            h.buyer
            h.item

            h.destroy
        end
    end
end
