Class {
	#name : 'LLMCExplainCommand',
	#superclass : 'SycSourceCodeCommand',
	#traits : 'TRefactoringCommandSupport',
	#classTraits : 'TRefactoringCommandSupport classTrait',
	#instVars : [
		'selectedTextInterval',
		'codeSelected'
	],
	#category : 'LLMCode',
	#package : 'LLMCode'
}

{ #category : 'activation' }
LLMCExplainCommand class >> contextMenuOrder [
	^ 1000
]

{ #category : 'activation' }
LLMCExplainCommand class >> sourceCodeMenuActivation [

	<classAnnotation>
	^ SycLLMMenuActivation
		  byItemOf: ClyLLMMenuGroup
		  order: self contextMenuOrder
		  for: ClySourceCodeContext
]

{ #category : 'converting' }
LLMCExplainCommand >> asRefactorings [

	self error: 'Not a refactoring'
]

{ #category : 'accessing' }
LLMCExplainCommand >> defaultMenuItemName [

	^ 'AI.Explain'
]

{ #category : 'execution' }
LLMCExplainCommand >> execute [

	| prompt api answer reader |
	prompt := String streamContents: [ :str |
		          str << 'Explain this Pharo piece of code:
```st
'.
		          str << codeSelected asString.
		          str << '
```' ].
	api := OllamaAPI new.
	api temperature: 0.7.
	api top_p: 0.9.
	api stream: true.
	answer := api query: prompt.
	reader := NeoJSONReader on: (ZnCharacterReadStream on: answer).
	[
	[ reader atEnd ] whileFalse: [
		| val |
		val := reader next.
		Transcript show: (val at: #response).
		(val at: #done) ifTrue: [ answer close ] ] ] forkAt:
		Processor lowIOPriority
]

{ #category : 'execution' }
LLMCExplainCommand >> readParametersFromContext: aSourceCodeContext [

	super readParametersFromContext: aSourceCodeContext.

	selectedTextInterval := aSourceCodeContext selectedTextInterval.
	codeSelected := aSourceCodeContext tool textMorph text
		                copyFrom: selectedTextInterval first
		                to: selectedTextInterval last
]
