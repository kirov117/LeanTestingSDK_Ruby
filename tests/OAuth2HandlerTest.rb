require 'minitest/autorun'

require_relative '../LeanTestingSDK/RubyClient'

class OAuth2HandlerTest < MiniTest::Test

	def test_OAuth2HandlerDefined
		OAuth2Handler
	end




	def test_OAuth2HandlerGenerateNonStrClientID
		assert_raises SDKInvalidArgException do
			OAuth2Handler.new(RubyClient.new).generateAuthLink(1, '', '')
		end
	end
	def test_OAuth2HandlerGenerateNonStrRedirectURI
		assert_raises SDKInvalidArgException do
			OAuth2Handler.new(RubyClient.new).generateAuthLink('', 1, '')
		end
	end
	def test_OAuth2HandlerGenerateNonStrScope
		assert_raises SDKInvalidArgException do
			OAuth2Handler.new(RubyClient.new).generateAuthLink('', '', 1)
		end
	end
	def test_OAuth2HandlerGenerateNonStrState
		assert_raises SDKInvalidArgException do
			OAuth2Handler.new(RubyClient.new).generateAuthLink('', '', '', 1)
		end
	end




	def test_OAuth2HandlerExchangeNonStrClientID
		assert_raises SDKInvalidArgException do
			client = RubyClient.new
			client.debugReturn = '{}'
			OAuth2Handler.new(client).exchangeAuthCode(1, '', '', '', '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrClientSecret
		assert_raises SDKInvalidArgException do
			client = RubyClient.new
			client.debugReturn = '{}'
			OAuth2Handler.new(client).exchangeAuthCode('', 1, '', '', '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrGrantType
		assert_raises SDKInvalidArgException do
			client = RubyClient.new
			client.debugReturn = '{}'
			OAuth2Handler.new(client).exchangeAuthCode('', '', 1, '', '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrCode
		assert_raises SDKInvalidArgException do
			client = RubyClient.new
			client.debugReturn = '{}'
			OAuth2Handler.new(client).exchangeAuthCode('', '', '', 1, '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrRedirectURI
		assert_raises SDKInvalidArgException do
			client = RubyClient.new
			client.debugReturn = '{}'
			OAuth2Handler.new(client).exchangeAuthCode('', '', '', '', 1)
		end
	end

end
