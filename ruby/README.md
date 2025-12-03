# Ruby

## Regex

[regex cheat sheet](https://www.rexegg.com/regex-quickstart.php)

define regex like:

```ruby
ROT_STRING = /([a-zA-Z])(\d+)/
```

### captures

```ruby
match_object = ROT_STRING.match(example_string)

# the entire match
match_object[0]

# an array of captures
match_object.captures

# this also works to get each capture group
match_object[1]
match_object[2] 
```

### offset

```ruby
# uses the same index as captures
# where the 0 is for the entire match
# and 1 ... onward for each capture group
match_object.offset(0)
```

## file open


### each line

```ruby
File.foreach('day1input.txt').with_index do |line, i|
  op(line)
end
```


**if you're using line.length don't forget to chomp to remove nl**

```line.chomp```

### file is one line

```ruby
# this problem has one single line
content = File.readlines('d2.txt')[0]
```

