class FibonacciCalculatorService
  attr_reader :input_num  # fobinacci数列に入力する値

  # publicメソッドをクラスメソッドとするやり方
  # https://blog.giftee.dev/2023-02-20-rails-service-object/
  def self.call(...)
    new(...).call
  end

  def initialize(input_num)
    @input_num = input_num
  end

  def call
    return fibonacci(@input_num)
  end

  # 引数nが正の値であることは，呼び出し元（controller側）で保証されているものとする
  def fibonacci(n)
    # fib[]: fibonacci数を次々と追加していくための配列
    fib = [0, 1]

    # fib配列に格納されたfibonacci数を用いて，次のfibonacci数を計算して追加する
    (2..n).each do |i|
      fib[i] = fib[i - 1] + fib[i - 2]
    end

    # fib配列の最後の要素が求めるfibonacci数である
    return fib[n]
  end
end