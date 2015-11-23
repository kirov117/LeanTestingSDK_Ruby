require 'minitest/autorun'

require_relative '../LeanTestingSDK/RubyClient'

class BaseClassesTest < MiniTest::Test

	# Entity
	def test_EntityDefined
		Entity
	end

	def test_EntityDataParsing
		data = {'id' => 1}
		entity = Entity.new(RubyClient.new, data)

		assert_equal entity.data, data
	end

	def test_EntityInstanceNonArrData
		assert_raises SDKInvalidArgException do
			Entity.new(RubyClient.new, '')
		end
	end
	def test_EntityInstanceEmptyData
		assert_raises SDKInvalidArgException do
			Entity.new(RubyClient.new, {})
		end
	end
	# END Entity



	# EntityHandler
	def test_EntityHandlerDefined
		EntityHandler
	end

	def test_EntityHandlerCreateNonArrFields
		assert_raises SDKInvalidArgException do
			EntityHandler.new(RubyClient.new).create('')
		end
	end
	def test_EntityHandlerCreateEmptyFields
		assert_raises SDKInvalidArgException do
			EntityHandler.new(RubyClient.new).create({})
		end
	end

	def test_EntityHandlerAllNonArrFilters
		assert_raises SDKInvalidArgException do
			EntityHandler.new(RubyClient.new).all('')
		end
	end
	def test_EntityHandlerAllInvalidFilters
		ex = assert_raises SDKInvalidArgException do
			EntityHandler.new(RubyClient.new).all({'XXXfilterXXX' => 9999})
		end
		assert_match 'XXXfilterXXX', ex.message
	end
	def test_EntityHandlerAllSupportedFilters
		EntityHandler.new(RubyClient.new).all({'include' => ''})
		EntityHandler.new(RubyClient.new).all({'limit' => 10})
		EntityHandler.new(RubyClient.new).all({'page' => 2})
	end

	def test_EntityHandlerFindNonIntID
		assert_raises SDKInvalidArgException do
			EntityHandler.new(RubyClient.new).find('')
		end
	end

	def test_EntityHandlerDeleteNonIntID
		assert_raises SDKInvalidArgException do
			EntityHandler.new(RubyClient.new).delete('')
		end
	end

	def test_EntityHandlerUpdateNonIntID
		assert_raises SDKInvalidArgException do
			EntityHandler.new(RubyClient.new).update('', {'x' => 5})
		end
	end
	def test_EntityHandlerUpdateNonArrFields
		assert_raises SDKInvalidArgException do
			EntityHandler.new(RubyClient.new).update(5, '')
		end
	end
	def test_EntityHandlerUpdateEmptyFields
		assert_raises SDKInvalidArgException do
			EntityHandler.new(RubyClient.new).update(5, {})
		end
	end
	# END EntityHandler

end
