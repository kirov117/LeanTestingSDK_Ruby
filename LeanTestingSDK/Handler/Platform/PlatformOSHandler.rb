class PlatformOSHandler < EntityHandler

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/platform/os', 'GET')
		EntityList.new(@origin, request, PlatformOS, filters)
	end

	def find(id)
		super

		req = APIRequest.new(@origin, '/v1/platform/os/' + id.to_s(), 'GET')
		PlatformOS.new(@origin, req.exec)
	end

end
