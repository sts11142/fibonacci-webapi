class FbController < ApplicationController
  def index
    n_str = params[:n]

    invalid_error = { "type" => "invalid-parameter", "title" => "パラメータの値が不正です" }

    # パラメータが存在しないとき → error
    if !n_str.present?
      return render json: {
        "status": 400,
        "errors": [ invalid_error ]
      }, status: 400
    end

    # 整数ではない or 負数のとき → error
    if (is_integer?(n_str) == false) || (n_str.to_i < 0)
      return render json: {
        "status": 400,
        "errors": [ invalid_error ]
      }, status: 400
    end

    # nは非負整数であることが保証されている
    n = n_str.to_i
    @result = FibonacciCalculatorService.call(n)  # fibonacci数を取得する

    return render status: 200, json: { "result": @result }
  end


  private

  # 引数の文字列が整数値であることを確認する
  #     "2.0".to_i → 2.to_s → "2" != "2.0"
  #     "str".to_i → 0.to_s → "0" != "str"
  def is_integer?(str)
    return str.to_i.to_s == str
  end
end
