Class {
	#name : 'AI4ChatMethodSourceTool',
	#superclass : 'LLMAPIChatObjectTool',
	#category : 'AI4Chat-Tools',
	#package : 'AI4Chat',
	#tag : 'Tools'
}

{ #category : 'initialization' }
AI4ChatMethodSourceTool >> initialize [

	super initialize.
	description := 'I return the source code of a method of a class of the Pharo system. Provide me the name of the class and the selector of the method'.
	name := 'Pharo Method Source'
]
