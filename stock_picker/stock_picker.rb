require 'optparse'
require_relative 'discrete_distribution_sampler'
require_relative 'discrete_distribution_sampler_tester'

def stock_picker(daily_prices)
    # Each index 'i' in the 'buy_day' array will contain an index 'j'. 'j' refers
    # to the best day from day 'i' forward to buy. For example, if buy_day[5] == 8
    # then day 8 is the best day to buy on if we started on day 5.
    buy_day = Array.new(daily_prices.length)
    # gains[i] simply contains the amount that would be earned if bought on
    # buy_day[i] and sold on sell_day[i].
    gains = Array.new(daily_prices.length)
    # The 'sell_day' array works the same way as 'buy'. Starting on day 'i', the 
    # value of sell_day[i] is the best day to sell on, assuming we started on day 'i'.
    sell_day = Array.new(daily_prices.length)
    # Set initial values (so that the loop does not go out of bounds with index [day + 1].
    # Start with the last day.
    # Whatever day the current day is, assume that is the starting day.
    # So the starting with the last day, we only have one option: buy
    # on the last day and sell on the last day.
    buy_day[daily_prices.length - 1] = daily_prices.length - 1
    sell_day[daily_prices.length - 1] = daily_prices.length - 1
    gains[daily_prices.length - 1] = 0
    max_price_forward_day = daily_prices.length - 1
    for day in (daily_prices.length - 2).downto(0)
        price = daily_prices[day]
        max_price_forward_day = daily_prices[day + 1] > daily_prices[max_price_forward_day] ? day + 1 : max_price_forward_day
        if ((gain = daily_prices[max_price_forward_day] - price) > gains[day + 1])
            # This day's solution is better than the next day's 
            # solution (and therefore any of the following day's
            # solutions).
            buy_day[day] = day
            sell_day[day] = max_price_forward_day
            gains[day] = gain
        else
            # The solution provided by the next day is better than
            # the solution provided by this day. So just point to
            # whatever the next day's solution is.
            gains[day] = gains[day + 1]
            buy_day[day] = buy_day[day + 1]
            sell_day[day] = sell_day[day + 1]
        end
    end
    return { "Buy Day" => buy_day[0], "Sell Day" => sell_day[0] }
end

def normalize(arr)
    sum = arr.reduce(:+)
    norm_arr = arr.map { |i| i*1.0 / sum }
    return norm_arr
end

def generate_pmf(max_v)
    cmf_pairs = []
    (1..max_v).each do |v|
        cmf_pairs.append([v, 1.0 / v**2])
    end
    values, weights = cmf_pairs.transpose
    norm_weights = normalize(weights)
    return [values, norm_weights].transpose

end

def generate_stock_prices(initial_v, num_days, day_max_change = 0.5)
    dds = DiscreteDistributionSampler.new(generate_pmf(10000))
    day_v = initial_v
    history = [day_v]
    (2..num_days).each do |day|
        while (day_change = dds.get_sample) > day_max_change*day_v
        end
        if rand <= 0.5
            day_v += day_change
        else
            day_v -= day_change
        end
        if day_v <= 0
            history.append(0)
            break
        end
        history.append(day_v)
    end
    return history
end

def get_options
    options = {}
    OptionParser.new do |opts|
        opts.banner = "Usage: stock_picker.rb [arguments]"

        opts.on("-i INITIAL_VALUE", "--initial-value=INITIAL_VALUE", Integer, "The initial price of the hypothetical stock") do |initial_value|
            options[:initial_value] = initial_value
        end

        opts.on("-n NUM-DAYS", "--num-days=NUM-DAYS", Integer, "Number of days to simulate") do |num_days|
            options[:num_days] = num_days
        end

        opts.on('-h', '--help', 'Display this help message') do
            puts opts
            exit
        end
    end.parse!
    return options
end

def test
    ddst = DiscreteDistributionSamplerTester.new
    if not ddst.test
        abort("Discrete Distribution Sampelr Tester failed")
    end
end

test

options = get_options
options[:num_days] ||= 50
options[:initial_value] ||= 50

stock_prices = generate_stock_prices(options[:initial_value], options[:num_days])
result = stock_picker(stock_prices)

puts "Stock prices over #{options[:num_days]} days:"
day = 0
stock_prices.each do |v|
    if day % 5 == 0
        print "Day #{day} : #{v}"
    else
        print ", #{v}"
    end
    if (day + 1) % 5 == 0
        puts
    end
    day += 1
end
result.each do |k,v|
    puts "#{k}: #{v}, at #{stock_prices[v]}"
end
gain = stock_prices[result['Sell Day']] - stock_prices[result['Buy Day']]
puts "Gain: #{gain}"
puts "Min price: #{stock_prices.min} on day #{stock_prices.rindex(stock_prices.min)}"
puts "Max price: #{stock_prices.max} on day #{stock_prices.rindex(stock_prices.max)}"
