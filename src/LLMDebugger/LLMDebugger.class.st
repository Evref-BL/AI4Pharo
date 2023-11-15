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

	| context |
	context := String streamContents: [ :stream |
		           stream << 'ERROR: '.

		           stream
		           <<
		           self stDebugger debuggerActionModel
			           statusStringForContext.
		           stream << String crlf.
		           stream << 'Error stack:'.
		           stream << String crlf.
		           self stDebugger debuggerActionModel
			           statusStringForContext.
		           stream << String lf.
		           stream << '---'.
		           stream << String lf.

		           ((self stDebugger debuggerActionModel session
			             stackOfSize: 5) copyFrom: 2 to: 5) reverse
			           do: [ :stack | stream << stack sourceCode ]
			           separatedBy: [
				           stream << String lf.
				           stream << String lf.
				           stream << '---'.
				           stream << String lf ] ].

	^ LLMPromptBuilder new
		  role: 'You are a debugging smalltalk assistant chatbot';
		  history: self history;
		  context: context;
		  buildPrompt
]

{ #category : #accessing }
LLMDebugger >> buildPrompt: context [

	^ LLMPromptBuilder new
		role: 'You are a debugging assistant chatbot';
		context: context;
		history: self history;
		buildPrompt
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
