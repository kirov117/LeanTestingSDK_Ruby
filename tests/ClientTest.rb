require 'bundler'
Bundler.require(:default, :test)

require_relative '../LeanTestingSDK/RubyClient'

class BaseClassesTest < MiniTest::Test

	def test_ClientDefined
		RubyClient.new
	end




	def test_ClientHasAuthObj
		assert_instance_of OAuth2Handler, RubyClient.new.auth
	end
	def test_ClientHasUserObj
		assert_instance_of UserHandler, RubyClient.new.user
	end
	def test_ClientHasProjectsObj
		assert_instance_of ProjectsHandler, RubyClient.new.projects
	end
	def test_ClientHasBugsObj
		assert_instance_of BugsHandler, RubyClient.new.bugs
	end
	def test_ClientHasAttachmentsObj
		assert_instance_of AttachmentsHandler, RubyClient.new.attachments
	end
	def test_ClientHasPlatformObj
		assert_instance_of PlatformHandler, RubyClient.new.platform
	end



	def test_InitialEmptyToken
		assert !RubyClient.new.getCurrentToken
	end
	def test_TokenParseStorage
		tokenName = '__token__test__'
		client = RubyClient.new
		client.attachToken(tokenName)

		assert_equal client.getCurrentToken, tokenName
	end
	def test_TokenParseNonStr
		assert_raises SDKInvalidArgException do
			RubyClient.new.attachToken(7182381)
		end
	end

end
