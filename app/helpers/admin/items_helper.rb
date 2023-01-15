module Admin::ItemsHelper
  def converting_to_jpy(price)
    "#{price.to_i(:delimited, delimiter: ',')}円"
  end
end
