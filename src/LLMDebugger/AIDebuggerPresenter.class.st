Class {
	#name : #AIDebuggerPresenter,
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
AIDebuggerPresenter >> buildExplainPrompt [

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
AIDebuggerPresenter >> buildPrompt [

	^ prompt text
]

{ #category : #initialization }
AIDebuggerPresenter >> currentStDebuggerContext [
   "A 'shortcut' to get the same currentContext of the StDebugger"
   ^ debugger stDebugger currentContext
]

{ #category : #'debugger extension' }
AIDebuggerPresenter >> debuggerExtensionToolName [
	
	^ 'AI Debugger'
]

{ #category : #initialization }
AIDebuggerPresenter >> defaultLayout [
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
AIDebuggerPresenter >> executePrompt: aPrompt [

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
AIDebuggerPresenter >> initializePresenters [
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
AIDebuggerPresenter >> setModelBeforeInitialization: aDebugger [

	debugger := AIDebugger new.
	debugger stDebugger: aDebugger
]

{ #category : #initialization }
AIDebuggerPresenter >> updatePresenter [
   "Called automatically when the debugger updates its state after stepping"
   "Your widgets should be updated here."
   super updatePresenter
]
