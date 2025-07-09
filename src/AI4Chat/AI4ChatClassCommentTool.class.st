"
Return the comment of a class
"
Class {
	#name : 'AI4ChatClassCommentTool',
	#superclass : 'LLMAPIChatObjectTool',
	#category : 'AI4Chat-Tools',
	#package : 'AI4Chat',
	#tag : 'Tools'
}

{ #category : 'api' }
AI4ChatClassCommentTool >> commentOfClass: aClassOrClassString [

	| class |
	class := self class environment
		         at: aClassOrClassString asSymbol 
		         ifAbsent: [ ^ 'class does not exist' ].
	^ class comment
]

{ #category : 'initialization' }
AI4ChatClassCommentTool >> initialize [

	super initialize.
	description := 'I return the comment of a class of the Pharo system given as String or "class does not exsit" in the other case'.
	name := 'Pharo Class Comment'.
	self symbol: #commentOfClass:
]
