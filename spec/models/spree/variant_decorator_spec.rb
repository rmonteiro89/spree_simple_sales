require 'spec_helper'

describe Spree::Variant do
  describe "#price_in" do
    it "returns the sale price if it is present" do
      variant = create(:variant, :sale_price => 8.00)
      expected = Spree::Price.new(:variant_id => variant.id, :currency => "USD", :amount => variant.sale_price)

      result = variant.price_in("USD")

      result.variant_id.should == expected.variant_id
      result.amount.to_f.should == expected.amount.to_f
      result.currency.should == expected.currency
    end

    it "returns the normal price if it is not on sale" do
      variant = create(:variant, :price => 15.00)
      expected = Spree::Price.new(:variant_id => variant.id, :currency => "USD", :amount => variant.price)

      result = variant.price_in("USD")

      result.variant_id.should == expected.variant_id
      result.amount.to_f.should == expected.amount.to_f
      result.currency.should == expected.currency
    end
  end
end
