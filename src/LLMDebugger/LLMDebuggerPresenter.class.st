Class {
	#name : #LLMDebuggerPresenter,
	#superclass : #SpPresenter,
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'debugger',
		'prompt',
		'explainButton',
		'promptButton',
		'result',
		'rawResult',
		'solveButton',
		'promptMethodList'
	],
	#category : #LLMDebugger
}

{ #category : #'debugger extension' }
LLMDebuggerPresenter >> appendResultText: aString [

	rawResult ifNil: [ rawResult := '' ].
	rawResult := rawResult , aString.
	result document: (Microdown parse: rawResult)
]

{ #category : #prompting }
LLMDebuggerPresenter >> createExplainPrompt [
	"Creates a prompt for the user to provide a detailed explanation of an error they encountered, including the error name and relevant code snippets from the stack trace."

	self debugger addUserSaid: (String streamContents: [ :stream |
			 stream
			 <<
			 'You are a smalltalk debugging assistant. Give me all pertinent information that I need to debug the error reported below. I give the the error name, then the code of the methods in the stack trace separated by ---.	Error Name: '.
			 stream
			 <<
			 self debugger stDebugger debuggerActionModel
				 statusStringForContext.
			 stream << String lf.
			 stream << String lf.
			 stream << '---'.
			 stream << String lf.
			 ((self debugger stDebugger debuggerActionModel session
				   stackOfSize: 5) copyFrom: 2 to: 5) reverse
				 do: [ :stack | stream << stack sourceCode ]
				 separatedBy: [
					 stream << String lf.
					 stream << String lf.
					 stream << '---'.
					 stream << String lf ].
			 stream << 'Finally propose the code that solves the bug' ])
]

{ #category : #prompting }
LLMDebuggerPresenter >> createPrompt [
	"
	1. Je cronstruit le nouveau text que je veux faire
	2. J'ajoute le nouveau text dans mon history
	"

	self debugger addUserSaid: prompt text
]

{ #category : #prompting }
LLMDebuggerPresenter >> createSolvePrompt [

	self debugger addUserSaid: (String streamContents: [ :stream |
			 stream
			 << 'You are a inline suggestion for code completion in an IDE.
I have this error: '.
			 stream
			 <<
			 self debugger stDebugger debuggerActionModel
				 statusStringForContext.
			 stream << String lf.
			 stream << 'This is the trace context in between ---'.
			 stream << String lf.
			 stream << '---'.
			 stream << String lf.

			 ((self debugger stDebugger debuggerActionModel session
				   stackOfSize: 5) copyFrom: 2 to: 5) reverse
				 do: [ :stack | stream << stack sourceCode ]
				 separatedBy: [
					 stream << String lf.
					 stream << String lf.
					 stream << '---'.
					 stream << String lf ].
			 stream << String lf.
			 stream << '---'.
			 stream << String lf.
			 stream
			 <<
			 'Do not provide any comment. Generate only the code to solve this issue!' ])
]

{ #category : #initialization }
LLMDebuggerPresenter >> currentStDebuggerContext [
   "A 'shortcut' to get the same currentContext of the StDebugger"
   ^ debugger stDebugger currentContext
]

{ #category : #'debugger extension' }
LLMDebuggerPresenter >> debuggerExtensionToolName [
	
	^ 'LLM Debugger'
]

{ #category : #layout }
LLMDebuggerPresenter >> defaultLayout [
	"An empty vertical box layout, for the moment"

	^ SpPanedLayout newTopToBottom
		  positionOfSlider: 20 percent;
		  add: #prompt;
		  add: (SpBoxLayout newTopToBottom
				   add: #promptMethodList
				   withConstraints: [ :constraints |
					   constraints height: self class toolbarHeight ];
				   add: (SpBoxLayout newLeftToRight
						    add: #promptButton;
						    add: #explainButton;
						    add: #solveButton;
						    yourself)
				   withConstraints: [ :constraints |
				   constraints height: self class toolbarHeight ];
				   add: #result;
				   yourself);
		  yourself
]

{ #category : #prompting }
LLMDebuggerPresenter >> executeOllamaPrompt [

	| answer ollama reader |
	[
	ollama := OllamaAPI new.
	ollama model: OPhindCodeLlamaModel new.
	ollama model tag: '34b-v2'.
	ollama temperature: 0.7.
"	ollama num_predict: 200."
	ollama top_p: 0.9.
	ollama stream: true.
	answer := ollama query: self debugger buildPrompt.
	reader := NeoJSONReader on: (ZnCharacterReadStream on: answer).
	[ reader atEnd ] whileFalse: [
		| val |
		val := reader next.
		self appendResultText: (val at: #response).
		(val at: #done) ifTrue: [ answer close. self debugger addLLMSaid: rawResult ] ] ] forkAt:
		Processor lowIOPriority
]

{ #category : #prompting }
LLMDebuggerPresenter >> executeOpenAIPrompt [

	| answer api object openAIResult |
	api := OAApi new.
	object := OARequestObject new.

	object addMessage: (OARequestMessage new
			 content: (self debugger buildPrompt);
			 yourself).

	api content: object.
	openAIResult := api perform.

	answer := openAIResult choices anyOne message at: #content.
	self updateResultText: answer.
	self debugger addLLMSaid: rawResult
]

{ #category : #prompting }
LLMDebuggerPresenter >> executePrompt [

	| api answer |
	api := HFAPI new.
	api model: HFMistralInstructModel new.
	api return_full_text: false.
	api max_new_tokens: 250.
	answer := api query: self debugger buildPrompt.
	self updateResultText: answer.
	self debugger addLLMSaid: rawResult
]

{ #category : #initialization }
LLMDebuggerPresenter >> initializePresenters [
	"Called automatically by the Spec framework. This method describes how the widgets are initialized"

	"There are no widget for the moment."

	prompt := self newText.
	prompt text: 'Explain the bug'.
	promptMethodList := self newDropList.
	promptMethodList items:
		{ #executePrompt. #executeOllamaPrompt. #executeOpenAIPrompt }.
	promptMethodList selectItem: self debugger class defaultPromptModel.
	promptButton := self newButton.
	promptButton label: 'Prompt!'.
	promptButton action: [
		self resetResultText.
		self createPrompt.
		self perform: promptMethodList selectedItem ].
	explainButton := self newButton.
	explainButton label: 'Explain!'.
	explainButton action: [
		self resetResultText.
		self createExplainPrompt.
		self perform: promptMethodList selectedItem ].
	solveButton := self newButton.
	solveButton label: 'Solve!'.
	solveButton action: [
		self resetResultText.
		self createSolvePrompt.
		self perform: promptMethodList selectedItem ].
	result := self instantiate: MicrodownPresenter
]

{ #category : #'debugger extension' }
LLMDebuggerPresenter >> resetResultText [

	self updateResultText: ''
]

{ #category : #'accessing - model' }
LLMDebuggerPresenter >> setModelBeforeInitialization: aDebugger [

	debugger := LLMDebugger new.
	debugger stDebugger: aDebugger
]

{ #category : #initialization }
LLMDebuggerPresenter >> updatePresenter [
   "Called automatically when the debugger updates its state after stepping"
   "Your widgets should be updated here."
   super updatePresenter
]

{ #category : #'debugger extension' }
LLMDebuggerPresenter >> updateResultText: aString [

	rawResult := aString.
	result document: (Microdown parse: rawResult)
]
