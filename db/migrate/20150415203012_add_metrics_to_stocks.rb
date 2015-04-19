class AddMetricsToStocks < ActiveRecord::Migration
  def change
  	# here we will add all sorts of trigger types we are interested in.
  	# These columns will only hold the most recent information.
  	add_column :stocks, :dividend_yield, :decimal, precision:8, scale:2
  	add_column :stocks, :dividend_per_share, :decimal, precision:8, scale:2
  	add_column :stocks, :percentchange_from200day_avg, :decimal, precision:8, scale:2
    add_column :stocks, :percentchange_from50day_avg, :decimal, precision:8, scale:2
    add_column :stocks, :percentchange_from52week_low, :decimal, precision:8, scale:2
    add_column :stocks, :percentchange_from52week_high, :decimal, precision:8, scale:2
    add_column :stocks, :volume, :decimal, precision:8, scale:2
    add_column :stocks, :eps, :decimal,  precision:8, scale:2
    add_column :stocks, :pe_ratio, :decimal,  precision:8, scale:2
  end
end
