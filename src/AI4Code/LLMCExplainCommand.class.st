Class {
	#name : 'LLMCExplainCommand',
	#superclass : 'SycSourceCodeCommand',
	#traits : 'TRefactoringCommandSupport',
	#classTraits : 'TRefactoringCommandSupport classTrait',
	#instVars : [
		'selectedTextInterval',
		'codeSelected'
	],
	#category : 'AI4Code',
	#package : 'AI4Code'
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

	| prompt api answer |
	prompt := String streamContents: [ :str |
			          str << 'Explain this Pharo piece of code:
```st
'.
			          str << codeSelected asString.
			          str << '
```' ].
	api := LLMAPI chat.
	api host: '127.0.0.1'.
	api port: 11434.

	api payload
		temperature: 0.7;
		top_p: 0.9;
		top_p: 1;
		model: 'devstral';
		messages: {
				(LLMAPIChatObjectMessage
					 role: 'system'
					 content: 'You are a usefull Pharo assistant').
				(LLMAPIChatObjectMessage role: 'user' content: prompt) }.
	answer := api performRequest.

	Transcript show: answer
]

{ #category : 'execution' }
LLMCExplainCommand >> readParametersFromContext: aSourceCodeContext [

	super readParametersFromContext: aSourceCodeContext.

	selectedTextInterval := aSourceCodeContext selectedTextInterval.
	codeSelected := aSourceCodeContext tool textMorph text
		                copyFrom: selectedTextInterval first
		                to: selectedTextInterval last
]
