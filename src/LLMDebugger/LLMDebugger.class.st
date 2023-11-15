Class {
	#name : #LLMDebugger,
	#superclass : #Object,
	#instVars : [
		'stDebugger'
	],
	#classInstVars : [
		'defaultPromptModel'
	],
	#category : #LLMDebugger
}

{ #category : #accessing }
LLMDebugger class >> defaultPromptModel [

	^ defaultPromptModel
]

{ #category : #accessing }
LLMDebugger class >> defaultPromptModel: anObject [

	defaultPromptModel := anObject
]

{ #category : #'as yet unclassified' }
LLMDebugger class >> llmDebuggerSettings: aBuilder [

	<systemsettings>
	(aBuilder group: #LLMDebugger)
		name: 'LLM Debugger';
		parent: #tools;
		with: [
			(aBuilder pickOne: #defaultPromptModel)
				label: 'Default LLM for the LLMDebugger';
				target: self;
				default: #executePrompt:;
				domainValues: {
						('OpenAI' -> #executeOpenAIPrompt:).
						('HuggingFace' -> #executePrompt:).
						('Ollama' -> #executeOllamaPrompt:) } ]
]

{ #category : #accessing }
LLMDebugger >> stDebugger [

	^ stDebugger
]

{ #category : #accessing }
LLMDebugger >> stDebugger: anObject [

	stDebugger := anObject
]
