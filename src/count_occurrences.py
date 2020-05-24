#!/usr/bin/env python3


fruit_list = ["apple", "pear", "banana", "kiwi", "watermelon", "carrot", "carrot", "apple", "apple", "apple", "pear","banana"]

# Method 1: using set() to get identical entry, then loop through to count
count_dic = {}
for fruit in set(fruit_list):
    count_dic[fruit] = fruit_list.count(fruit)

print(count_dic)


# Method 2: get() method in Dictionary, if already existing, get default value and plus 1
#           if first time show up, get() returns zero, then plus 1
advanced_count_dic = {}

for fruit in fruit_list:
    advanced_count_dic[fruit] = advanced_count_dic.get(fruit, 0) + 1

print(advanced_count_dic)



