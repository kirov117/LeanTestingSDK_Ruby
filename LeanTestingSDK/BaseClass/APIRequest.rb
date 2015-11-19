#
# Represents an API Request definition.
#
# An APIRequest's parameters can be modified on demand and can be executed multiple times for the same instance.
#
class APIRequest

	#
	# Constructs API request definition.
	#
	# Arguments:
	#	origin   RubyClient -- Originating client reference
	#	endpoint String     -- API endpoint
	#	method   String     -- Method for cURL call - supports GET, POST, PUT or DELETE only
	#	opts     Hash       -- (optional) Additional options to pass to request.
	#							Request parameters (if any) must bep assed here.
	#
	# Exceptions:
	#	SDKInvalidArgException if method is non-string.
	#	SDKInvalidArgException if unsupported method is provided.
	#	SDKInvalidArgException if endpoint is non-string.
	#	SDKInvalidArgException if opts param is not a hash.
	#
	def initialize(origin, endpoint, method, opts = nil)
		@default_ops = {									# Basic support for extended opts
			'base_uri'	=> 'https://api.leantesting.com',	# assumed default for API base
			'form_data'	=> false,							# sets content type to multipart/form-data if true
			'params'	=> {}								# params to be pased in request
		}

		if !opts
			opts = {}
		end

		if !method.is_a? String
			raise SDKInvalidArgException, '`method` must be a string'
		elsif !['GET', 'POST', 'PUT', 'DELETE'].include? method
			raise SDKInvalidArgException, 'unsupported ' + method + ' `method`'
		elsif !endpoint.is_a? String
			raise SDKInvalidArgException, '`endpoint` must be a string'
		elsif !opts.is_a? Hash
			raise SDKInvalidArgException, '`opts` must be a hash'
		end

		@opts = @default_ops.clone
		self.updateOpts(opts)

		@origin		= origin
		@endpoint	= endpoint
		@method		= method
	end

	#
	# Updates options list inside API request definition.
	#
	# Arguments:
	#	opts Hash -- (optional) Additional options array to merge with previous option values
	#
	# Exceptions:
	#	SDKInvalidArgException if opts param is not a hash.
	#	SDKInvalidArgException if provided parameter list is non-hash parameter.
	#
	def updateOpts(opts = nil)
		if !opts
			opts = {}
		end

		if !opts.is_a? Hash
			raise SDKInvalidArgException, '`opts` must be a hash'
		elsif opts.has_key? 'params' && !opts['params'].is_a?(Hash)
			raise SDKInvalidArgException '`opts[\'params\']` must be a hash'
		end

		@opts.merge!(opts)
	end

	#
	# Executes cURL call as per current API definition state.
	#
	# Exceptions:
	#	SDKErrorResponseException   if the remote response is an error.
	#		A server response is interpreted as an error if obtained status code differs from expected status code.
	#		Expected status codes are `200 OK` for GET/POST/PUT, `204 No Content` for DELETE.
	#	SDKBadJSONResponseException if the remote response contains erronated or invalid JSON contents
	#
	# Returns:
	#	Hash    -- In case of successful request, a JSON decoded object is returned.
	#	Boolean -- If a DELETE request is issued, returns true if call is successful (exception otherwise).
	#
	def exec
		ch = Curl::Easy.new

		callUrl = @opts['base_uri'] + @endpoint

		if @origin.getCurrentToken.is_a? String
			ch.headers['Authorization'] = 'Bearer ' + @origin.getCurrentToken
		end

		ch.url = callUrl

		ch.header_in_body = false

		case @method
		when 'GET'
			expectedHTTPStatus = 200

			callUrl += '?' + Curl::postalize(@opts['params'])
			ch.url = callUrl

			ch.http_get
		when 'POST'
			expectedHTTPStatus = 200

			if @opts['form_data'] == true && (@opts.has_key? 'file_path')
				ch.headers['Content-Type'] = 'multipart/form-data'
				ch.multipart_form_post = true

				ch.http_post(Curl::PostField.file('file', @opts['file_path']))
			else
				jsonData = JSON.generate(@opts['params'])

				ch.headers['Content-Type'] = 'application/json'
				ch.headers['Content-Length'] = jsonData.length

				ch.http_post(jsonData)
			end
		when 'PUT'
			expectedHTTPStatus = 200

			jsonData = JSON.generate(@opts['params'])

			ch.headers['Content-Type'] = 'application/json'
			ch.headers['Content-Length'] = jsonData.length

			ch.http_put(jsonData)
		when 'DELETE'
			expectedHTTPStatus = 204

			ch.http_delete
		end

		curlData	= ch.body_str
		curlStatus	= ch.status.to_i()

		if curlStatus != expectedHTTPStatus
			raise SDKErrorResponseException, curlData
		end

		ch.close
		ch = nil

		if @method == 'DELETE'
			return true
		end

		begin
			jsonData = JSON.parse(curlData)
		rescue JSON::ParserError
			raise SDKBadJSONResponseException, curlData
		end

		return jsonData

	end

end
