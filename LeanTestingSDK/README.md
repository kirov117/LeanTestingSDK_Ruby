# LeanTestingSDK_Python
####*Lean Testing Python Client Library*

[Uses the Lean Testing API](https://leantesting.com/en/api-docs)

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- Including Lean Testing Python SDK
```python
from LeanTestingSDK.PyClient import PyClient as LeanTestingClient
```

- Creating a new instance
```python
LT = LeanTestingClient()
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- Get Current **Token**
```python
LT.getCurrentToken()
```

- Attach New **Token**
```python
LT.attachToken('9ErdKZXpGPnvHuJ9di92eAFqrp14GKvfHMyclGGh')
```

- Generate **Authorization URL**
```python
generatedURL = LT.auth.generateAuthLink(
	'DHxaSvtpl91Xos4vb7d0GKkXRu0GJxd5Rdha2HHx',
	'https://www.example.com/appurl/',
	'admin',
	'a3ahdh2iqhdasdasfdjahf26'
)
print( generatedURL )
```

- Exchange Authorization Code For **Access TOKEN**
```python
token = LT.auth.exchangeAuthCode(
	'DHxaSvtpl91Xos4vb7d0GKkXRu0GJxd5Rdha2HHx',
	'DpOZxNbeL1arVbjUINoA9pOhgS8FNQsOkpE4CtXU',
	'authorization_code',
	'sOgY2DT47B2K0bqashnk0E6wUaYgbbspwdy9kGrk',
	'https://www.example.com/appurl/'
)
print( token )
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- Get **User** Information
```python
LT.user.getInformation()
```

- Get **User** Organizations
```python
LT.user.organizations.all().toArray()
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- List All **Projects**
```python
LT.projects.all().toArray()
```

- Create A New **Project**
```python
newProject = LT.projects.create({
	'name': 'Project135',
	'organization_id': 5779
})
print( newProject.data )
```

- Retrieve An Existing **Project**
```python
LT.projects.find(3515).data
```


- List **Project Sections**
```python
LT.projects.find(3515).sections.all().toArray()
```

- Adding A **Project Section**
```python
newSection = LT.projects.find(3515).sections.create({
	'name': 'SectionName'
})
print( newSection.data )
```


- List **Project Versions**
```python
LT.projects.find(3515).versions.all().toArray()
```

- Adding A **Project Version**
```python
newVersion = LT.projects.find(3515).versions.create({
	'number': 'v0.3.1104'
})
print( newVersion.data )
```


- List **Project Users**
```python
LT.projects.find(3515).users.all().toArray()
```


- List **Bug Type Scheme**
```python
LT.projects.find(3515).bugTypeScheme.all().toArray()
```

- List **Bug Status Scheme**
```python
LT.projects.find(3515).bugStatusScheme.all().toArray()
```

- List **Bug Severity Scheme**
```python
LT.projects.find(3515).bugSeverityScheme.all().toArray()
```

- List **Bug Reproducibility Scheme**
```python
LT.projects.find(3515).bugReproducibilityScheme.all().toArray()
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- List All **Bugs** In A Project
```python
LT.projects.find(3515).bugs.all().toArray()
```

- Create A New **Bug**
```python
newBug = LT.projects.find(3515).bugs.create({
	'title': 'Something bad happened...',
	'status_id': 1,
	'severity_id': 2,
	'project_version_id': 10242
})
print( newBug.data )
```

- Retrieve Existing **Bug**
```python
LT.bugs.find(38483).data
```

- Update A **Bug**
```python
updatedBug = LT.bugs.update(118622, {
	'title': 'Updated title',
	'status_id': 1,
	'severity_id': 2,
	'project_version_id': 10242
})
print( updatedBug.data )
```

- Delete A **Bug**
```python
LT.bugs.delete(118622)
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- List Bug **Comments**
```python
LT.bugs.find(38483).comments.all().toArray()
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- List Bug **Attachments**
```python
LT.bugs.find(38483).attachments.all().toArray()
```

- Upload An **Attachment**
```python
filePath = '/place/Downloads/Images/1370240743_2294218.jpg'
newAttachment = LT.bugs.find(38483).attachments.upload(filePath)
p.pprint( newAttachment.data )
```

- Retrieve An Existing **Attachment**
```python
LT.attachments.find(21515).data
```

- Delete An **Attachment**
```python
LT.attachments.delete(75258)
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~

- List **Platform Types**
```python
LT.platform.types.all().toArray()
```

- Retrieve **Platform Type**
```python
LT.platform.types.find(1).data
```


- List **Platform Devices**
```python
LT.platform.types.find(1).devices.all().toArray()
```

- Retrieve Existing **Device**
```python
LT.platform.devices.find(11).data
```


- List **OS**
```python
LT.platform.os.all().toArray()
```

- Retrieve Existing **OS**
```python
LT.platform.os.find(1).data
```

- List **OS Versions**
```python
LT.platform.os.find(1).versions.all().toArray()
```


- List **Browsers**
```python
LT.platform.browsers.all().toArray()
```

- Retrieve Existing **Browser**
```python
LT.platform.browsers.find(1).data
```

- List **Browser Versions**
```python
LT.platform.browsers.find(1).versions.all().toArray()
```

######~~/////////////////////////////////////////////////////////////////////////////////////~~
