# LeanTestingSDK_Ruby
####*Lean Testing Ruby Client Library*

[Uses the Lean Testing API](https://leantesting.com/en/api-docs)

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- Including Lean Testing Ruby SDK
```ruby
require_relative 'LeanTestingSDK/RubyClient'
```

- Creating a new instance
```ruby
LT = RubyClient.new
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- Get Current **Token**
```ruby
LT.getCurrentToken
```

- Attach New **Token**
```ruby
LT.attachToken('9ErdKZXpGPnvHuJ9di92eAFqrp14GKvfHMyclGGh')
```

- Generate **Authorization URL**
```ruby
generatedURL = LT.auth.generateAuthLink(
	'DHxaSvtpl91Xos4vb7d0GKkXRu0GJxd5Rdha2HHx',
	'https://www.example.com/appurl/',
	'admin',
	'a3ahdh2iqhdasdasfdjahf26'
)
p generatedURL
```

- Exchange Authorization Code For **Access TOKEN**
```ruby
token = LT.auth.exchangeAuthCode(
	'DHxaSvtpl91Xos4vb7d0GKkXRu0GJxd5Rdha2HHx',
	'DpOZxNbeL1arVbjUINoA9pOhgS8FNQsOkpE4CtXU',
	'authorization_code',
	'sOgY2DT47B2K0bqashnk0E6wUaYgbbspwdy9kGrk',
	'https://www.example.com/appurl/'
)
p token
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- Get **User** Information
```ruby
LT.user.getInformation
```

- Get **User** Organizations
```ruby
LT.user.organizations.all.toArray
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- List All **Projects**
```ruby
LT.projects.all.toArray
```

- Create A New **Project**
```ruby
newProject = LT.projects.create({
	'name' => 'Project135',
	'organization_id' => 5779
})
p newProject.data
```

- Retrieve An Existing **Project**
```ruby
LT.projects.find(3515).data
```


- List **Project Sections**
```ruby
LT.projects.find(3515).sections.all.toArray
```

- Adding A **Project Section**
```ruby
newSection = LT.projects.find(3515).sections.create({
	'name' => 'SectionName'
})
p newSection.data
```


- List **Project Versions**
```ruby
LT.projects.find(3515).versions.all.toArray
```

- Adding A **Project Version**
```ruby
newVersion = LT.projects.find(3515).versions.create({
	'number' => 'v0.3.1104'
})
p newVersion.data
```


- List **Project Users**
```ruby
LT.projects.find(3515).users.all.toArray
```


- List **Bug Type Scheme**
```ruby
LT.projects.find(3515).bugTypeScheme.all.toArray
```

- List **Bug Status Scheme**
```ruby
LT.projects.find(3515).bugStatusScheme.all.toArray
```

- List **Bug Severity Scheme**
```ruby
LT.projects.find(3515).bugSeverityScheme.all.toArray
```

- List **Bug Reproducibility Scheme**
```ruby
LT.projects.find(3515).bugReproducibilityScheme.all.toArray
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- List All **Bugs** In A Project
```ruby
LT.projects.find(3515).bugs.all.toArray
```

- Create A New **Bug**
```ruby
newBug = LT.projects.find(3515).bugs.create({
	'title' => 'Something bad happened...',
	'status_id' => 1,
	'severity_id' => 2,
	'project_version_id' => 10242
})
p newBug.data
```

- Retrieve Existing **Bug**
```ruby
LT.bugs.find(38483).data
```

- Update A **Bug**
```ruby
updatedBug = LT.bugs.update(118622, {
	'title' => 'Updated title',
	'status_id' => 1,
	'severity_id' => 2,
	'project_version_id' => 10242
})
p updatedBug.data
```

- Delete A **Bug**
```ruby
LT.bugs.delete(118622)
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- List Bug **Comments**
```ruby
LT.bugs.find(38483).comments.all.toArray
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- List Bug **Attachments**
```ruby
LT.bugs.find(38483).attachments.all.toArray
```

- Upload An **Attachment**
```ruby
filePath = '/place/Downloads/Images/1370240743_2294218.jpg'
newAttachment = LT.bugs.find(38483).attachments.upload(filePath)
p newAttachment.data
```

- Retrieve An Existing **Attachment**
```ruby
LT.attachments.find(21515).data
```

- Delete An **Attachment**
```ruby
LT.attachments.delete(75258)
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- List **Platform Types**
```ruby
LT.platform.types.all.toArray
```

- Retrieve **Platform Type**
```ruby
LT.platform.types.find(1).data
```


- List **Platform Devices**
```ruby
LT.platform.types.find(1).devices.all.toArray
```

- Retrieve Existing **Device**
```ruby
LT.platform.devices.find(11).data
```


- List **OS**
```ruby
LT.platform.os.all.toArray
```

- Retrieve Existing **OS**
```ruby
LT.platform.os.find(1).data
```

- List **OS Versions**
```ruby
LT.platform.os.find(1).versions.all.toArray
```


- List **Browsers**
```ruby
LT.platform.browsers.all.toArray
```

- Retrieve Existing **Browser**
```ruby
LT.platform.browsers.find(1).data
```

- List **Browser Versions**
```ruby
LT.platform.browsers.find(1).versions.all.toArray
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- Using **Filters**
```ruby
LT.projects.find(3515).bugs.all({'limit' => 2, 'page' => 5}).toArray
```

- **Entity List** Functions
```ruby
browsers = LT.platform.browsers.all
p browsers.total
p browsers.totalPages
p browsers.count
p browsers.toArray
```

- **Entity List** Iterator
When used in for loops, entity lists will automatically cycle to first page, regardless of `page` filter.
After ending the loop, the entity list will **NOT** revert to first page or the initial instancing `page` filter setting in order not to cause useless API request calls.
```ruby
comments = LT.bugs.find(38483).comments.all({'limit' => 1})
comments.each{ |page| p page }
```

- **Entity List** Manual Iteration
```ruby
comments = LT.bugs.find(38483).comments.all({'limit' => 1})
p comments.toArray

# Will return false if unable to move forwards
comments.next;      p comments.toArray

# Will return false if already on last page
comments.last;      p comments.toArray

# Will return false if unable to move backwards
comments.previous;  p comments.toArray

# Will return false if already on first page
comments.first;     p comments.toArray
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~
