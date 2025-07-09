Class {
	#name : 'AI4ChatClassMethodListTool',
	#superclass : 'LLMAPIChatObjectTool',
	#category : 'AI4Chat-Tools',
	#package : 'AI4Chat',
	#tag : 'Tools'
}

{ #category : 'initialization' }
AI4ChatClassMethodListTool >> initialize [

	super initialize.
	description := 'I return the list of method of a class of the Pharo system given as String or "class does not exsits" in the other case'.
	name := 'Pharo Method List'.
	self symbol: #methodsOfClass:
]

{ #category : 'api' }
AI4ChatClassMethodListTool >> methodsOfClass: aClassString [

	| class |
	class := self class environment
		         at: aClassString asSymbol
		         ifAbsent: [ ^ 'class does not exist' ].
	^ String streamContents: [ :str |
			  class allMethods
				  do: [ :m |
						  str
							  << '- ';
							  << m name ]
				  separatedBy: [ str << String lf ] ]
]
