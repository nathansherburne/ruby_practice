Stock Picker
========================
Generates a list of daily stock prices and picks the best days to buy and sell.

Generating
------------------------
To generate a list of stock prices, completely random numbers would not be realistic. While the method used here is fairly simple, it is able to provide much more realistic hypothetical stock prices. This is based on the assumption that, in general, the larger the fluctuation, the less likely it is to happen. Only dealing with whole numbers, weights are placed on each number according to its inverse square. This is called discrete distribution sampling. And the alias method is used to perform it efficiently.

Finding Optimal Solution
------------------------
Dynamic programming is used to reduce this problem from O(n^2^) to O(n).

Usage
------------------------

```
Usage: stock_picker.rb [arguments]
    -iINITIAL-VALUE,                 The initial integer price of the hypothetical stock
        --initial-value
    -n, --num-days=NUM-DAYS          Integer number of days to simulate
    -h, --help                       Display this help message
```

Example
------------------------
```
$ ruby stock_picker.rb -i 100 -n 25

Stock prices over 25 days:
Day 0 : 100, 101, 100, 101, 100
Day 5 : 97, 98, 123, 124, 123
Day 10 : 124, 123, 121, 122, 123
Day 15 : 127, 128, 127, 128, 129
Day 20 : 127, 139, 140, 142, 141
Buy Day: 5, at 97
Sell Day: 23, at 142
Gain: 45
Min price: 97 on day 5
Max price: 142 on day 23
```
