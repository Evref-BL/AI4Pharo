Class {
	#name : 'LLMDebugger',
	#superclass : 'Object',
	#instVars : [
		'stDebugger',
		'history'
	],
	#classInstVars : [
		'defaultPromptModel'
	],
	#category : 'LLMDebugger',
	#package : 'LLMDebugger'
}

{ #category : 'accessing' }
LLMDebugger class >> defaultPromptModel [

	^ defaultPromptModel
]

{ #category : 'accessing' }
LLMDebugger class >> defaultPromptModel: anObject [

	defaultPromptModel := anObject
]

{ #category : 'as yet unclassified' }
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

{ #category : 'adding' }
LLMDebugger >> addLLMSaid: aLLMPrompt [
	"Adds an LLM message with prompt aLLMPrompt to the conversation history."

	self history addMessage: (LLMMessage llmSaid: aLLMPrompt)
]

{ #category : 'adding' }
LLMDebugger >> addUserSaid: aLLMPrompt [
	"Adds a new message to the history with the content being what user said represented by provided LLMPrompt."

	self history addMessage: (LLMMessage iSaid: aLLMPrompt)
]

{ #category : 'accessing' }
LLMDebugger >> buildPrompt [
	"Build a prompt for the user in a chatting interface, indicating the current context of execution (error or last methods), including the call stack if possible."

	| context maxStack callstack |
	context := String streamContents: [ :stream |
		           stream
			           << 'ERROR: ';
			           <<
				           self stDebugger debuggerActionModel
					           statusStringForContext.
		           stream << String crlf.
		           stream << 'METHODS CALL STACK:'.
		           stream << String crlf.
		           self stDebugger debuggerActionModel
			           statusStringForContext.
		           stream << String lf.
		           stream << '---'.
		           stream << String lf.
		           callstack := self stDebugger debuggerActionModel session
			                        stackOfSize: 5.
		           maxStack := callstack size > 5
			                       ifTrue: [ 5 ]
			                       ifFalse: [ callstack size ].
		           (callstack copyFrom: 2 to: maxStack) reverse
			           do: [ :stack | stream << stack sourceCode ]
			           separatedBy: [
				           stream << String lf.
				           stream << String lf.
				           stream << '---'.
				           stream << String lf ] ].
	^ LLMPromptBuilder new
		  role: 'You are a debugging smalltalk assistant chatbot. Answer with short answer.';
		  history: self history;
		  context: context;
		  buildPrompt
]

{ #category : 'accessing' }
LLMDebugger >> buildPrompt: context [
	"Construct and return a LLMPromptBuilder object with specified role, context, and history for prompt building."

	^ LLMPromptBuilder new
		  role: 'You are a debugging assistant chatbot';
		  context: context;
		  history: self history;
		  buildPrompt
]

{ #category : 'accessing' }
LLMDebugger >> history [
	"Returns the history object or value"

	^ history
]

{ #category : 'accessing' }
LLMDebugger >> history: anObject [
	"Set the value of history to the provided object."

	history := anObject
]

{ #category : 'accessing' }
LLMDebugger >> initialize [
	"Initialize method: Sets the initial state of an instance of this class, setting the history attribute to a newly created instance of LLMHistory."

	super initialize.
	history := LLMHistory new
]

{ #category : 'accessing' }
LLMDebugger >> stDebugger [
	"Returns an instance of the Smalltalk debugger."

	^ stDebugger
]

{ #category : 'accessing' }
LLMDebugger >> stDebugger: anObject [
	"Opens a debugger with the provided object"

	stDebugger := anObject
]
