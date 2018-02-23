Stock Picker
========================
Generates a list of daily stock prices and picks the best days to buy and sell.

Generating
------------------------
To generate a list of stock prices, completely random numbers would not be realistic. While the method used here is fairly simple, it is able to provide much more realistic hypothetical stock prices. This is based on the assumption that, in general, the larger the fluctuation, the less likely it is to happen. Only dealing with whole numbers, weights are placed on each number according to its inverse square. This is called discrete distribution sampling. And the alias method is used to perform it efficiently.

Finding Optimal Solution
------------------------
Dynamic programming is used to reduce this problem from O(n^2) to O(n).


```
Usage: stock_picker.rb [arguments]
    -iINITIAL-VALUE,                 The initial integer price of the hypothetical stock
        --initial-value
    -n, --num-days=NUM-DAYS          Integer number of days to simulate
    -h, --help                       Display this help message

Example:
    $ ruby stock_picker.rb -i 100 -n 150
```
