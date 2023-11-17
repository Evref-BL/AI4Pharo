Class {
	#name : #SycOpenLLMInMethodMenuCommand,
	#superclass : #SycOpenContextMenuCommand,
	#category : #LLMCode
}

{ #category : #activation }
SycOpenLLMInMethodMenuCommand class >> methodEditorShortcutActivation [

	<classAnnotation>
	^ CmdShortcutActivation by: $a meta shift for: ClySourceCodeContext
]

{ #category : #execution }
SycOpenLLMInMethodMenuCommand >> activationStrategy [

	^ SycLLMMenuActivation
]

{ #category : #execution }
SycOpenLLMInMethodMenuCommand >> cmCommandClass [

	^ SycSourceCodeCmCommand
]

{ #category : #accessing }
SycOpenLLMInMethodMenuCommand >> defaultMenuItemName [

	^ 'AI'
]
