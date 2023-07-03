require 'rails_helper'

RSpec.describe "Fibonacci API", type: :request do
  # テストケース，response bodyは仕様を確認すること

  # No.1  正例  パラメータが適切な値
  describe 'No.1  GET /fb?n=5 (valid parameter)' do
    # エンドポイント，パラメータ，リクエスト形式
    before do
      get '/fb', params: { n: 10 }
    end

    # 200: リクエストが正常に処理された
    it 'return 200 status' do
      expect(response).to have_http_status(200)
    end

    # fibonacci(10)=55
    it 'returns correct JSON' do
      json = JSON.parse(response.body)  # response.body は文字列
      expect(json['result']).to eq(55)
    end
  end


  # No.2  正例  パラメータn=0
  describe 'No.2  GET /fb?n=0 (valid parameter)' do
    before do
      get '/fb', params: { n: 0 }
    end

    # 200: リクエストが正常に処理された
    it 'returns 200 status' do
      expect(response).to have_http_status(200)
    end

    # fibonacci(0)=0
    it 'returns correct JSON' do
      json = JSON.parse(response.body)  # resuponse.body は文字列
      expect(json['result']).to eq(0)
    end
  end


  # No.3  正例  パラメータn=1
  describe 'No.3  GET /fb?n=1 (valid parameter)' do
    before do
      get '/fb', params: { n: 1 }
    end

    # 200: リクエストが正常に処理された
    it 'returns 200 status' do
      expect(response).to have_http_status(200)
    end

    # fibonacci(0)=0
    it 'returns correct JSON' do
      json = JSON.parse(response.body)  # resuponse.body は文字列
      expect(json['result']).to eq(1)
    end
  end


  # No.4  負例  パラメータが不動小数点数
  describe 'No.4  GET /fb?n=1.5 (invalid parameter float-param)' do
    before do
      get '/fb', params: { n: 1.5 }
    end

    # 400: リクエストに異常があり，正しく受付されなかった
    it 'returns 400 status' do
      expect(response).to have_http_status(400)
    end

    # error-type: 'incalid-parameter'
    it 'returns correct (error) JSON' do
      json = JSON.parse(response.body)  # resuponse.body は文字列
      expect(json['status']).to eq(400)
      expect(json['errors']).to eq( [ 'type' => 'invalid-parameter', 'title' => 'パラメータの値が不正です' ] )
    end
  end
  

  # No.5  負例  パラメータに値を指定しない
  describe 'No.5  GET /fb?n= (invalid parameter no-param)' do
    before do
      get '/fb?n='
    end

    # 400: リクエストに異常があり，正しく受付されなかった
    it 'returns 400 status' do
      expect(response).to have_http_status(400)
    end

    # error-type: 'incalid-parameter'
    it 'returns correct (error) JSON' do
      json = JSON.parse(response.body)  # resuponse.body は文字列
      expect(json['status']).to eq(400)
      expect(json['errors']).to eq( [ 'type' => 'invalid-parameter', 'title' => 'パラメータの値が不正です' ] )
    end
  end


    # No.6  負例  パラメータを指定しない
    describe 'No.6  GET /fb (invalid parameter no-param)' do
      before do
        get '/fb'
      end
  
      # 400: リクエストに異常があり，正しく受付されなかった
      it 'returns 400 status' do
        expect(response).to have_http_status(400)
      end
  
      # error-type: 'incalid-parameter'
      it 'returns correct (error) JSON' do
        json = JSON.parse(response.body)  # resuponse.body は文字列
        expect(json['status']).to eq(400)
        expect(json['errors']).to eq( [ 'type' => 'invalid-parameter', 'title' => 'パラメータの値が不正です' ] )
      end
    end


  # No.7  負例  パラメータの値が文字列
  describe 'No.7  GET /fb?n="string" (invalid parameter string)' do
    before do
      get '/fb', params: { n: "string" }
    end

    # 400: リクエストに異常があり，正しく受付されなかった
    it 'returns 400 status' do
      expect(response).to have_http_status(400)
    end

    # error-type: 'incalid-parameter'
    it 'returns correct (error) JSON' do
      json = JSON.parse(response.body)  # resuponse.body は文字列
      expect(json['status']).to eq(400)
      expect(json['errors']).to eq( [ 'type' => 'invalid-parameter', 'title' => 'パラメータの値が不正です' ] )
    end
  end


  # No.8  負例  パラメータの値が負数
  describe 'No.8  GET /fb?n=-10 (invalid parameter negative)' do
    before do
      get '/fb', params: { n: -10 }
    end

    # 400: リクエストに異常があり，正しく受付されなかった
    it 'returns 400 status' do
      expect(response).to have_http_status(400)
    end

    # error-type: 'incalid-parameter'
    it 'returns correct (error) JSON' do
      json = JSON.parse(response.body)  # resuponse.body は文字列
      expect(json['status']).to eq(400)
      expect(json['errors']).to eq( [ 'type' => 'invalid-parameter', 'title' => 'パラメータの値が不正です' ] )
    end
  end

end
