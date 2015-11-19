class PlatformBrowsersHandler < EntityHandler

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/platform/browsers', 'GET')
		EntityList.new(@origin, request, PlatformBrowser, filters)
	end

	def find(id)
		super

		req = APIRequest.new(@origin, '/v1/platform/browsers/' + id.to_s(), 'GET')
		PlatformBrowser.new(@origin, req.exec)
	end

end
