base_url = {
	'demoqa':'https://demoqa.com/automation-practice-form'
}

ids = {
	'radios':{
		'gender':{
			'male':'gender-radio-1',
			'female':'gender-radio-2',
			'other':'gender-radio-3'
		}
	}
}

xpaths = {
	'required_fields':{
		'texts':{
			'first_name':'//*[@id="firstName"]',
			'last_name':'//*[@id="lastName"]',
		},
		'nums':{
			'mobile':'//*[@id="userNumber"]',
		}		
	}
}

texts = {
	'home_page':{
		'title':'Student Registration Form',
		'msgs':{
			'success':'Thanks for submitting the form'
		}
	}
}