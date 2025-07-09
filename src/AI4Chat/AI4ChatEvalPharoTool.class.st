Class {
	#name : 'AI4ChatEvalPharoTool',
	#superclass : 'LLMAPIChatObjectTool',
	#category : 'AI4Chat-Tools',
	#package : 'AI4Chat',
	#tag : 'Tools'
}

{ #category : 'initialization' }
AI4ChatEvalPharoTool >> initialize [

	super initialize.
	description := 'I execute Pharo/SmallTalk code and return the result'.
	name := 'Pharo Code Executor'
]
