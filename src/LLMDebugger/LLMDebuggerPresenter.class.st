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
		'result'
	],
	#category : #LLMDebugger
}

{ #category : #prompting }
LLMDebuggerPresenter >> buildExplainPrompt [

	^ String streamContents: [ :stream |
		  stream
		  <<
			  'You are a smalltalk debugging assistant. Give me all pertinent information that I need to debug the error reported below. I give the the error name, then the code of the methods in the stack trace separated by ---.
	
Error Name: '.
		  stream
		  <<
		  self debugger stDebugger debuggerActionModel
			  statusStringForContext.
		  stream << String lf.
		  stream << String lf.
		  stream << '---'.
		  stream << String lf.

		  ((self debugger stDebugger debuggerActionModel session
			   stackOfSize: 5) copyFrom: 2 to: 5 ) reverse
			  do: [ :stack | stream << stack sourceCode ]
			  separatedBy: [
				  stream << String lf.
				  stream << String lf.
				  stream << '---'.
				  stream << String lf ].
			
			stream << 'Finally propose the code that solves the bug' ]
]

{ #category : #prompting }
LLMDebuggerPresenter >> buildPrompt [

	^ prompt text
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

{ #category : #initialization }
LLMDebuggerPresenter >> defaultLayout [
	"An empty vertical box layout, for the moment"

	^ SpBoxLayout newTopToBottom
		  add: #prompt;
		  add: (SpBoxLayout newLeftToRight
				   add: #promptButton;
				   add: #explainButton;
				   yourself)
		  withConstraints: [ :constraints |
		  constraints height: self class toolbarHeight ];
		  add: #result;
		  yourself
]

{ #category : #prompting }
LLMDebuggerPresenter >> executePrompt: aPrompt [

	| api answer |
	api := HFAPI new.
	api model: HFMistralInstructModel new.
	api return_full_text: false.
	api max_new_tokens: 200.
	api max_time: 10.
	answer := api query: aPrompt.
	result text: answer
]

{ #category : #initialization }
LLMDebuggerPresenter >> initializePresenters [
	"Called automatically by the Spec framework. This method describes how the widgets are initialized"

	"There are no widget for the moment."

	prompt := self newTextInput.
	prompt text: 'Explain the bug'.
	promptButton := self newButton.
	promptButton label: 'Prompt!'.
	promptButton action: [ self executePrompt: self buildPrompt ].
	explainButton := self newButton.
	explainButton label: 'Explain!'.
	explainButton action: [ self executePrompt: self buildExplainPrompt ].
	result := self newText
]

{ #category : #initialization }
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