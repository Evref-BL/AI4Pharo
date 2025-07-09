Class {
	#name : 'AI4ChatClassDefinitionTool',
	#superclass : 'LLMAPIChatObjectTool',
	#category : 'AI4Chat-Tools',
	#package : 'AI4Chat',
	#tag : 'Tools'
}

{ #category : 'initialization' }
AI4ChatClassDefinitionTool >> initialize [

	super initialize.
	description := 'I return the definition of a class of the Pharo system given as String or "class does not exsits" in the other case'.
	name := 'Pharo Class Definition'
]
