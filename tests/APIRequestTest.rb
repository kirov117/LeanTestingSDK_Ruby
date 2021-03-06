require 'bundler'
Bundler.require(:default, :test)

require_relative '../LeanTestingSDK/RubyClient'

class APIRequestTest < MiniTest::Test

	def test_APIRequestDefined
		APIRequest
	end




	def test_APIRequestInstanceNonStrEndpoint
		assert_raises SDKInvalidArgException do
			APIRequest.new(RubyClient.new, 12751, 'GET')
		end
	end
	def test_APIRequestInstanceNonStrMethod
		assert_raises SDKInvalidArgException do
			APIRequest.new(RubyClient.new, '/', 1233)
		end
	end
	def test_APIRequestInstanceSupportedMethod
		APIRequest.new(RubyClient.new, '/', 'GET')
		APIRequest.new(RubyClient.new, '/', 'POST')
		APIRequest.new(RubyClient.new, '/', 'PUT')
		APIRequest.new(RubyClient.new, '/', 'DELETE')
	end
	def test_APIRequestInstanceNonSupportedMethod
		assert_raises SDKInvalidArgException do
			APIRequest.new(RubyClient.new, '/', 'XXX')
		end
	end
	def test_APIRequestInstanceNonArrOpts
		assert_raises SDKInvalidArgException do
			APIRequest.new(RubyClient.new, '/', 'GET', 12123)
		end
	end
	def test_APIRequestBadJSONResponse
		req = APIRequest.new(RubyClient.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> '{xxxxxxxxx', 'status'=> 200})

		ex = assert_raises SDKBadJSONResponseException do
			req.exec
		end
		assert_match '{xxxxxxxxx', ex.message
	end






	def test_APIRequestExpectedStatus
		req = APIRequest.new(RubyClient.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> '{"X": "X"}', 'status'=> 200})
		req.exec

		req = APIRequest.new(RubyClient.new, '/any/method', 'POST')
		req.expects(:call).returns({'data'=> '{"X": "X"}', 'status'=> 200})
		req.exec

		req = APIRequest.new(RubyClient.new, '/any/method', 'PUT')
		req.expects(:call).returns({'data'=> '{"X": "X"}', 'status'=> 200})
		req.exec

		req = APIRequest.new(RubyClient.new, '/any/method', 'DELETE')
		req.expects(:call).returns({'data'=> '1', 'status'=> 204})
		req.exec
	end






	def test_APIRequestUnexpectedStatusDELETE
		req = APIRequest.new(RubyClient.new, '/any/method', 'DELETE')
		req.expects(:call).returns({'data'=> 'XXXyyy', 'status'=> 200})

		ex = assert_raises SDKErrorResponseException do
			req.exec
		end
		assert_match 'XXXyyy', ex.message
	end





	def test_APIRequestUnexpectedStatusGET
		req = APIRequest.new(RubyClient.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> 'XXXyyy', 'status'=> 204})

		ex = assert_raises SDKErrorResponseException do
			req.exec
		end
		assert_match 'XXXyyy', ex.message
	end
	def test_APIRequestUnexpectedStatusPOST
		req = APIRequest.new(RubyClient.new, '/any/method', 'POST')
		req.expects(:call).returns({'data'=> 'XXXyyy', 'status'=> 204})

		ex = assert_raises SDKErrorResponseException do
			req.exec
		end
		assert_match 'XXXyyy', ex.message
	end
	def test_APIRequestUnexpectedStatusPUT
		req = APIRequest.new(RubyClient.new, '/any/method', 'PUT')
		req.expects(:call).returns({'data'=> 'XXXyyy', 'status'=> 204})

		ex = assert_raises SDKErrorResponseException do
			req.exec
		end
		assert_match 'XXXyyy', ex.message
	end




	def test_APIRequestEmptyRespGET
		req = APIRequest.new(RubyClient.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> '{}', 'status'=> 200})

		ex = assert_raises SDKUnexpectedResponseException do
			req.exec
		end
		assert_match 'Empty', ex.message
	end
	def test_APIRequestEmptyRespPOST
		req = APIRequest.new(RubyClient.new, '/any/method', 'POST')
		req.expects(:call).returns({'data'=> '{}', 'status'=> 200})

		ex = assert_raises SDKUnexpectedResponseException do
			req.exec
		end
		assert_match 'Empty', ex.message
	end
	def test_APIRequestEmptyRespPUT
		req = APIRequest.new(RubyClient.new, '/any/method', 'PUT')
		req.expects(:call).returns({'data'=> '{}', 'status'=> 200})

		ex = assert_raises SDKUnexpectedResponseException do
			req.exec
		end
		assert_match 'Empty', ex.message
	end

end
