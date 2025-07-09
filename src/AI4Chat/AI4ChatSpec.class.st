"
Represents a GUI presenter for a chat application.

•	open: Opens a new instance of the chat presenter.
•	defaultLayout: Defines the vertical layout for the chat including toolbar and notebook.
•	initialExtent: Calculates the initial size of the window based on font size and row height.
•	initializePresenters: Initializes the components like the notebook and toolbar.
•	title: Provides the title for the chat window.
"
Class {
	#name : 'AI4ChatSpec',
	#superclass : 'SpPresenter',
	#instVars : [
		'toolbar',
		'notebook'
	],
	#category : 'AI4Chat-Spec',
	#package : 'AI4Chat',
	#tag : 'Spec'
}

{ #category : 'examples' }
AI4ChatSpec class >> menuCommandOn: aBuilder [

	<worldMenu>
	(aBuilder item: #'Open AI4Chat')
		order: 1000;
		action: [ self open ];
		help: 'Open an AI4Chat wincow'
]

{ #category : 'examples' }
AI4ChatSpec class >> open [
	<example>
	
	^ self new open
]

{ #category : 'layout' }
AI4ChatSpec >> addNewChat [

    | newPage |
    newPage := SpNotebookPage
        title: 'New Chat'
        icon: (self iconNamed: #announcement)
        provider: [ AI4ChatSpecChat new ].
    notebook addPage: newPage.
    notebook selectPage: newPage
]

{ #category : 'layout' }
AI4ChatSpec >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: toolbar expand: false;
		  add: notebook;
		  yourself
]

{ #category : 'specs' }
AI4ChatSpec >> initialExtent [

	| fontWidth rowHeight |
	fontWidth := (StandardFonts defaultFont widthOfString: 'M').
	rowHeight := self class inputTextHeight.

	^ (40@25) * (fontWidth @ rowHeight)
	
]

{ #category : 'initialization' }
AI4ChatSpec >> initializePresenters [ 

    notebook := self newNotebook.
    toolbar := self newToolbar.
    
    toolbar add: (SpToolbarButtonPresenter new
        label: 'New Chat';
        icon: (self iconNamed: #add);
        help: 'Create a new chat';
        action: [ self addNewChat ];
        yourself).

    notebook addPage: (SpNotebookPage
        title: 'Chat'
        icon: (self iconNamed: #announcement)
        provider: [ AI4ChatSpecChat new ])
]

{ #category : 'accessing' }
AI4ChatSpec >> notebook [

	^ notebook
]

{ #category : 'accessing' }
AI4ChatSpec >> notebook: anObject [

	notebook := anObject
]

{ #category : 'specs' }
AI4ChatSpec >> title [
	
	^ 'LLM Chat'
]

{ #category : 'accessing' }
AI4ChatSpec >> toolbar [

	^ toolbar
]

{ #category : 'accessing' }
AI4ChatSpec >> toolbar: anObject [

	toolbar := anObject
]
