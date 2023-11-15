Class {
	#name : #LLMDebugger,
	#superclass : #Object,
	#instVars : [
		'stDebugger',
		'history'
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
				default: #executePrompt;
				domainValues: {
						('OpenAI' -> #executeOpenAIPrompt).
						('HuggingFace' -> #executePrompt).
						('Ollama' -> #executeOllamaPrompt) } ]
]

{ #category : #adding }
LLMDebugger >> addLLMSaid: aLLMPrompt [

	self history addMessage: (LLMMessage llmSaid: aLLMPrompt)
]

{ #category : #adding }
LLMDebugger >> addUserSaid: aLLMPrompt [

	self history addMessage: (LLMMessage iSaid: aLLMPrompt)
]

{ #category : #accessing }
LLMDebugger >> buildPrompt [

	^ (String streamContents: [ :str |
		   str
		   <<
		   'You are talking with a chatbot. The chat history is as follows:'.
		   str << String crlf.

		   self history messageStack do: [ :message |
			   str
				   << '[';
				   << message user;
				   << ']';
				   << ':'.
			   str << message text.
			   str << String crlf ].
		   str
		   <<
		   '"Now, you are asking to answer the following question. Generate a response' ])
		  recordInfo
]

{ #category : #accessing }
LLMDebugger >> history [

	^ history
]

{ #category : #accessing }
LLMDebugger >> history: anObject [

	history := anObject
]

{ #category : #accessing }
LLMDebugger >> initialize [

	super initialize.
	history := LLMHistory new
]

{ #category : #accessing }
LLMDebugger >> stDebugger [

	^ stDebugger
]

{ #category : #accessing }
LLMDebugger >> stDebugger: anObject [

	stDebugger := anObject
]
