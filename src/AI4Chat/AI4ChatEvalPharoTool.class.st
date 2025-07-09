"
I can execute Pharo code and return the result
"
Class {
	#name : 'AI4ChatEvalPharoTool',
	#superclass : 'LLMAPIChatObjectTool',
	#category : 'AI4Chat-Tools',
	#package : 'AI4Chat',
	#tag : 'Tools'
}

{ #category : 'execution' }
AI4ChatEvalPharoTool >> executeWithArguments: arguments [
	"Implement this if you want to extend tools and use its default mecanism"

	(arguments isNil or: [ arguments isEmpty ]) ifTrue: [
		^ 'please provide the code to be executed' ].
	^ [ SmalltalkImage current compiler evaluate: arguments first value ]
		  on: Exception
		  do: [ :exce | exce message ]
]

{ #category : 'initialization' }
AI4ChatEvalPharoTool >> initialize [

	super initialize.
	description := 'I execute Pharo/SmallTalk code and return the result'.
	name := 'Pharo Code Executor'
]
