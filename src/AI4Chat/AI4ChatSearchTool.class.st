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
	name := 'Pharo Search'.
	self symbol: #search:
]

{ #category : 'api' }
AI4ChatSearchTool >> search: aString [

	| model |
	model := StSpotterModel new.
	model processSearch: aString on: StSpotter new.
	self waitUntilEnded: model.
	^ String streamContents: [ :str |
			  model steps anyOne results
				  do: [ :result |
						  str
							  << '- ';
							  << result content printString ]
				  separatedBy: [ str << String lf ] ]
]

{ #category : 'private' }
AI4ChatSearchTool >> waitUntilEnded: model [

	[ (StSpotterModel delayBeforeQuery + 50 milliSeconds) wait ]
		doWhileTrue: [
		model scheduler workers anySatisfy: [ :each | each isBusy ] ]
]
