Class {
	#name : 'AI4ChatClassCommentTool',
	#superclass : 'LLMAPIChatObjectTool',
	#category : 'AI4Chat-Tools',
	#package : 'AI4Chat',
	#tag : 'Tools'
}

{ #category : 'initialization' }
AI4ChatClassCommentTool >> initialize [

	super initialize.
	description := 'I return the comment of a class of the Pharo system given as String or "class does not exsits" in the other case'.
	name := 'Pharo Class Comment'
]
