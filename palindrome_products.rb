
def is_palindrome?(n)
  n.to_s == n.to_s.reverse
end

products = []
(100..999).each { |a| (a..999).each { |b| products << a * b } }
puts products.reverse.find { |p| is_palindrome?(p) }


