require 'bundler'
Bundler.require(:default, :test)

require_relative '../../LeanTestingSDK/RubyClient'

class LiveRequestsTest < MiniTest::Test

	def setup
		@client = RubyClient.new
		@client.attachToken('6cOb1uNIMFyyJQdK33N9lxjECw5AJom1L3iKcVPw')

		@sampleProjectID = 3515
		@sampleBugID = 38483
		@sampleOrganizationID = 2464
		@sampleAttachmmentID = 21515
		@samplePlatformTypeID = 1
		@sampleDeviceID = 11
		@sampleOSID = 1
		@sampleBrowserId = 1
	end



	# USER
	def test_GetUserInformation
		info = @client.user.getInformation()

		assert_instance_of Hash, info

		assert info.has_key? 'id'
		assert info.has_key? 'username'
		assert info.has_key? 'first_name'
		assert info.has_key? 'last_name'
		assert info.has_key? 'email'
	end
	def test_GetUserOrganizations
		org = @client.user.organizations.all.toArray

		assert_instance_of Array, org

		assert org.length >= 1

		assert org[0].has_key? 'id'
		assert org[0].has_key? 'name'
	end
	# END USER




	# PROJECT
	def test_ListAllProjects
		prj = @client.projects.all.toArray

		assert_instance_of Array, prj

		assert prj.length >= 1

		assert prj[0].has_key? 'id'
		assert prj[0].has_key? 'name'
		assert prj[0].has_key? 'owner_id'
		assert prj[0].has_key? 'organization_id'
	end
	def test_CreateNewProject
		_name = 'Project135'
		_orgid = @sampleOrganizationID

		newProject = @client.projects.create({
			'name'=> _name,
			'organization_id'=> _orgid
		})

		data = newProject.data

		assert_instance_of Hash, data

		assert data.has_key? 'id'
		assert data.has_key? 'name'
		assert data.has_key? 'owner_id'
		assert data.has_key? 'organization_id'

		assert_equal _name, data['name']
		assert_equal _orgid, data['organization_id']
	end
	def test_RetrieveExistingProject
		project = @client.projects.find(@sampleProjectID).data

		assert_instance_of Hash, project

		assert project.has_key? 'id'
		assert project.has_key? 'name'
		assert project.has_key? 'owner_id'
		assert project.has_key? 'organization_id'
	end

	def test_ListProjectSections
		sect = @client.projects.find(@sampleProjectID).sections.all.toArray

		assert_instance_of Array, sect

		assert sect.length >= 1

		assert sect[0].has_key? 'id'
		assert sect[0].has_key? 'name'
		assert sect[0].has_key? 'project_id'
	end
	def test_AddProjectSection
		_name = 'SectionName999'

		newSection = @client.projects.find(@sampleProjectID).sections.create({
			'name'=> _name
		})

		data = newSection.data

		assert_instance_of Hash, data

		assert data.has_key? 'id'
		assert data.has_key? 'name'
		assert data.has_key? 'project_id'

		assert_equal _name, data['name']
	end

	def test_ListProjectVersions
		vers = @client.projects.find(@sampleProjectID).versions.all.toArray

		assert_instance_of Array, vers

		assert vers.length >= 1

		assert vers[0].has_key? 'id'
		assert vers[0].has_key? 'number'
		assert vers[0].has_key? 'project_id'
	end
	def test_AddProjectVersion
		_number = 'v2.0.0'

		newVersion = @client.projects.find(@sampleProjectID).versions.create({
			'number'=> _number
		})

		data = newVersion.data

		assert_instance_of Hash, data

		assert data.has_key? 'id'
		assert data.has_key? 'number'
		assert data.has_key? 'project_id'

		assert_equal _number, data['number']
	end

	def test_ListProjectUsers
		usr = @client.projects.find(@sampleProjectID).users.all.toArray

		assert_instance_of Array, usr

		assert usr.length >= 1

		assert usr[0].has_key? 'id'
		assert usr[0].has_key? 'username'
		assert usr[0].has_key? 'first_name'
		assert usr[0].has_key? 'last_name'
		assert usr[0].has_key? 'email'
	end

	def test_ListProjectBugTypeScheme
		scheme = @client.projects.find(@sampleProjectID).bugTypeScheme.all.toArray

		assert_instance_of Array, scheme

		assert scheme.length >= 1

		assert scheme[0].has_key? 'id'
		assert scheme[0].has_key? 'name'
	end
	def test_ListProjectBugStatusScheme
		scheme = @client.projects.find(@sampleProjectID).bugStatusScheme.all.toArray

		assert_instance_of Array, scheme

		assert scheme.length >= 1

		assert scheme[0].has_key? 'id'
		assert scheme[0].has_key? 'name'
	end
	def test_ListProjectBugSeverityScheme
		scheme = @client.projects.find(@sampleProjectID).bugSeverityScheme.all.toArray

		assert_instance_of Array, scheme

		assert scheme.length >= 1

		assert scheme[0].has_key? 'id'
		assert scheme[0].has_key? 'name'
	end
	def test_ListProjectBugReproducibilityScheme
		scheme = @client.projects.find(@sampleProjectID).bugReproducibilityScheme.all.toArray

		assert_instance_of Array, scheme

		assert scheme.length >= 1

		assert scheme[0].has_key? 'id'
		assert scheme[0].has_key? 'name'
	end
	# END PROJECT



	# BUG
	def test_ListBugsInProject
		bugs = @client.projects.find(@sampleProjectID).bugs.all.toArray

		assert_instance_of Array, bugs

		assert bugs.length >= 1

		assert bugs[0].has_key? 'id'
		assert bugs[0].has_key? 'title'
		assert bugs[0].has_key? 'status_id'
		assert bugs[0].has_key? 'severity_id'
		assert bugs[0].has_key? 'project_version_id'
		assert bugs[0].has_key? 'project_section_id'
		assert bugs[0].has_key? 'type_id'
		assert bugs[0].has_key? 'reproducibility_id'
		assert bugs[0].has_key? 'assigned_user_id'
		assert bugs[0].has_key? 'description'
		assert bugs[0].has_key? 'expected_results'
	end
	def test_CreateNewBug
		_title = 'Bugzilla000111'
		_status_id = 2
		_severity_id = 2
		_project_version_id = 10242
		_project_section_id = 12675
		_type_id = 4
		_reproducibility_id = 2
		_assigned_user_id = 4650
		_description = 'Descrdescrdescr'
		_expected_results = 'Expecexpecexpec'
		_steps = ['first do this', 'then do that', 'finally...']
		_platform = {'device_model_id'=> 11, 'os'=> 'Android', 'os_version_id'=> 207}


		newBug = @client.projects.find(@sampleProjectID).bugs.create({
			'title'=> _title,
			'status_id'=> _status_id,
			'severity_id'=> _severity_id,
			'project_version_id'=> _project_version_id,
			'project_section_id'=> _project_section_id,
			'type_id'=> _type_id,
			'reproducibility_id'=> _reproducibility_id,
			'assigned_user_id'=> _assigned_user_id,
			'description'=> _description,
			'expected_results'=> _expected_results,
			'steps'=> _steps,
			'platform'=> _platform
		})

		data = newBug.data

		assert_instance_of Hash, data

		assert data.has_key? 'id'
		assert data.has_key? 'title'
		assert data.has_key? 'status_id'
		assert data.has_key? 'severity_id'
		assert data.has_key? 'project_version_id'
		assert data.has_key? 'project_section_id'
		assert data.has_key? 'type_id'
		assert data.has_key? 'reproducibility_id'
		assert data.has_key? 'assigned_user_id'
		assert data.has_key? 'description'
		assert data.has_key? 'expected_results'
		assert data.has_key? 'steps'
		assert data.has_key? 'platform'

		assert_instance_of Array, data['steps']
		assert_instance_of Hash, data['platform']

		assert_equal 3, data['steps'].length

		assert_equal _title, data['title']
		assert_equal _status_id, data['status_id']
		assert_equal _severity_id, data['severity_id']
		assert_equal _project_version_id, data['project_version_id']
		assert_equal _project_section_id, data['project_section_id']
		assert_equal _type_id, data['type_id']
		assert_equal _reproducibility_id, data['reproducibility_id']
		assert_equal _assigned_user_id, data['assigned_user_id']
		assert_equal _description, data['description']
		assert_equal _expected_results, data['expected_results']

		assert_equal _steps[0], data['steps'][0]['text']

		assert_equal _platform['device_model_id'], data['platform']['model']['id']
		assert_equal _platform['os'], data['platform']['os']['name']
		assert_equal _platform['os_version_id'], data['platform']['os_version']['id']
	end
	def test_RetrieveExistingBug
		bug = @client.bugs.find(@sampleBugID).data

		assert_instance_of Hash, bug

		assert bug.has_key? 'id'
		assert bug.has_key? 'title'
		assert bug.has_key? 'status_id'
		assert bug.has_key? 'severity_id'
		assert bug.has_key? 'project_version_id'
		assert bug.has_key? 'project_section_id'
		assert bug.has_key? 'type_id'
		assert bug.has_key? 'reproducibility_id'
		assert bug.has_key? 'assigned_user_id'
		assert bug.has_key? 'description'
		assert bug.has_key? 'expected_results'
	end
	def test_UpdateBug
		_title = 'Upddssszz'
		_status_id = 1
		_severity_id = 1
		_project_version_id = 10242
		_project_section_id = 12675
		_type_id = 3
		_assigned_user_id = 4650
		_description = 'NJSDESCR'
		_expected_results = 'NJSXEXPR'


		updatedBug = @client.bugs.update(@sampleBugID, {
			'title'=> _title,
			'status_id'=> _status_id,
			'severity_id'=> _severity_id,
			'project_version_id'=> _project_version_id,
			'project_section_id'=> _project_section_id,
			'type_id'=> _type_id,
			'assigned_user_id'=> _assigned_user_id,
			'description'=> _description,
			'expected_results'=> _expected_results
		})

		data = updatedBug.data

		assert_instance_of Hash, data

		assert data.has_key? 'id'
		assert data.has_key? 'title'
		assert data.has_key? 'status_id'
		assert data.has_key? 'severity_id'
		assert data.has_key? 'project_version_id'
		assert data.has_key? 'project_section_id'
		assert data.has_key? 'type_id'
		assert data.has_key? 'assigned_user_id'
		assert data.has_key? 'description'
		assert data.has_key? 'expected_results'

		assert_equal _title, data['title']
		assert_equal _status_id, data['status_id']
		assert_equal _severity_id, data['severity_id']
		assert_equal _project_version_id, data['project_version_id']
		assert_equal _project_section_id, data['project_section_id']
		assert_equal _type_id, data['type_id']
		assert_equal _assigned_user_id, data['assigned_user_id']
		assert_equal _description, data['description']
		assert_equal _expected_results, data['expected_results']
	end
	# END BUG



	# BUG COMMENTS
	def test_ListBugComments
		comments = @client.bugs.find(@sampleBugID).comments.all.toArray

		assert_instance_of Array, comments

		assert comments.length >= 1

		assert comments[0].has_key? 'id'
		assert comments[0].has_key? 'text'
		assert comments[0].has_key? 'owner_id'
	end
	# END BUG COMMENTS




	# BUG ATTACHMENTS
	def test_ListBugAttachments
		atc = @client.bugs.find(@sampleBugID).attachments.all.toArray

		assert_instance_of Array, atc

		assert atc.length >= 1

		assert atc[0].has_key? 'id'
		assert atc[0].has_key? 'owner_id'
		assert atc[0].has_key? 'url'
	end
	def test_CreateNewAttachment
		_fp = File.expand_path(File.dirname(__FILE__)) + '/../res/upload_sample.jpg'

		new_attachment = @client.bugs.find(@sampleBugID).attachments.upload(_fp)

		data = new_attachment.data

		assert_instance_of Hash, data

		assert data.has_key? 'id'
		assert data.has_key? 'owner_id'
		assert data.has_key? 'url'
	end
	def test_RetrieveExistingAttachment
		atc = @client.attachments.find(@sampleAttachmmentID).data

		assert_instance_of Hash, atc

		assert atc.has_key? 'id'
		assert atc.has_key? 'owner_id'
		assert atc.has_key? 'url'
	end
	# END BUG ATTACHMENTS





	# PLATFORM
	def test_ListPlatformTypes
		types = @client.platform.types.all.toArray

		assert_instance_of Array, types

		assert types.length >= 1

		assert types[0].has_key? 'id'
		assert types[0].has_key? 'name'
	end
	def test_RetrievePlatformType
		type_ = @client.platform.types.find(@samplePlatformTypeID).data

		assert_instance_of Hash, type_

		assert type_.has_key? 'id'
		assert type_.has_key? 'name'
	end

	def test_ListPlatformDevices
		devs = @client.platform.types.find(@samplePlatformTypeID).devices.all.toArray

		assert_instance_of Array, devs

		assert devs.length >= 1

		assert devs[0].has_key? 'id'
		assert devs[0].has_key? 'name'
	end
	def test_RetrievePlatformDevice
		dev = @client.platform.devices.find(@sampleDeviceID).data

		assert_instance_of Hash, dev

		assert dev.has_key? 'id'
		assert dev.has_key? 'name'
	end

	def test_ListOS
		os = @client.platform.os.all.toArray

		assert_instance_of Array, os

		assert os.length >= 1

		assert os[0].has_key? 'id'
		assert os[0].has_key? 'name'
	end
	def test_RetrieveOS
		os = @client.platform.os.find(@sampleOSID).data

		assert_instance_of Hash, os

		assert os.has_key? 'id'
		assert os.has_key? 'name'
	end
	def test_ListOSVersions
		osv = @client.platform.os.find(@sampleOSID).versions.all.toArray

		assert_instance_of Array, osv

		assert osv.length >= 1

		assert osv[0].has_key? 'id'
		assert osv[0].has_key? 'number'
	end

	def test_ListBrowsers
		browsers = @client.platform.browsers.all.toArray

		assert_instance_of Array, browsers

		assert browsers.length >= 1

		assert browsers[0].has_key? 'id'
		assert browsers[0].has_key? 'name'
	end
	def test_RetrieveBrowser
		browser = @client.platform.browsers.find(@sampleBrowserId).data

		assert_instance_of Hash, browser

		assert browser.has_key? 'id'
		assert browser.has_key? 'name'
	end
	def test_ListBrowserVersions
		brw = @client.platform.browsers.find(@sampleBrowserId).versions.all.toArray

		assert_instance_of Array, brw

		assert brw.length >= 1

		assert brw[0].has_key? 'id'
		assert brw[0].has_key? 'name'
	end
	# END PLATFORM



	# INVALID FIELDS
	def test_CreateNewProjectIncomplete

		ex = assert_raises SDKIncompleteRequestException do
			@client.projects.create({'organization_id'=> 0})
		end
		assert_match 'name', ex.message
	end
	def test_CreateNewProjectUnsupported

		ex = assert_raises SDKUnsupportedRequestException do
			@client.projects.create({'name'=> '', 'fxxxxxx'=> ''})
		end
		assert_match 'fxxxxxx', ex.message
	end

	def test_AddProjectSectionUnsupported
		p = @client.projects.find(@sampleProjectID)

		ex = assert_raises SDKUnsupportedRequestException do
			p.sections.create({'name'=> '', 'fxxxxxx'=> ''})
		end
		assert_match 'fxxxxxx', ex.message
	end

	def test_AddProjectVersionUnsupported
		ex = assert_raises SDKUnsupportedRequestException do
			@client.projects.find(@sampleProjectID).versions.create({'number'=> '', 'fxxxxxx'=> ''})
		end
		assert_match 'fxxxxxx', ex.message
	end

	def test_CreateNewBugIncomplete
		_title = 'Bugzilla000111'
		_status_id = 2
		_severity_id = 2

		ex = assert_raises SDKIncompleteRequestException do
			@client.projects.find(@sampleProjectID).bugs.create({
				'title'=> _title, 'status_id'=> _status_id, 'severity_id'=> _severity_id
			})
		end
		assert_match 'project_version', ex.message
	end

	def test_CreateNewBugUnsupported
		_title = 'Bugzilla000111'
		_status_id = 2
		_severity_id = 2
		_project_version_id = 10242

		ex = assert_raises SDKUnsupportedRequestException do
			@client.projects.find(@sampleProjectID).bugs.create({
				'title'=> _title, 'status_id'=> _status_id, 'severity_id'=> _severity_id,
				'project_version_id'=> _project_version_id, 'fxxxxxx'=> ''
			})
		end
		assert_match 'fxxxxxx', ex.message
	end

	def test_CreateNewAttachmentNonStrFilepath
		ex = assert_raises SDKInvalidArgException do
			@client.bugs.find(@sampleBugID).attachments.upload(111)
		end
		assert_match 'filepath', ex.message
	end
	# END INVALID FIELDS




	# MISC
	def test_ForbiddenResponse
		ex = assert_raises SDKErrorResponseException do
			@client.bugs.find(1)
		end
		assert_match 'forbidden', ex.message
	end
	def test_MissingResponse
		ex = assert_raises SDKErrorResponseException do
			@client.bugs.find(999999)
		end
		assert_match '404', ex.message
	end
	def test_InvalidToken
		@client.attachToken('6cOb1uNIMFyyJQdK33N9lxjECw5AJom1L3xxxxxx')
		ex = assert_raises SDKErrorResponseException do
			@client.projects.find(@sampleProjectID)
		end
		assert_match 'denied', ex.message
	end
	def test_NoToken
		cl = RubyClient.new
		ex = assert_raises SDKErrorResponseException do
			cl.projects.find(@sampleProjectID)
		end
		assert_match 'access token', ex.message
	end
	# END MISC

end
