"
I use the spotter capability to search things in the Pharo image based on a string
"
Class {
	#name : 'AI4ChatSearchTool',
	#superclass : 'LLMAPIChatObjectTool',
	#category : 'AI4Chat-Tools',
	#package : 'AI4Chat',
	#tag : 'Tools'
}

{ #category : 'initialization' }
AI4ChatSearchTool >> initialize [

	super initialize.
	description := 'I can search methods or classes based on a string (with a upercase to search for class, lowercase a method)'.
	name := 'Pharo Search'
]
