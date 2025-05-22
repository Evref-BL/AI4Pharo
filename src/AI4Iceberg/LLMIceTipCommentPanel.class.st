Class {
	#name : 'LLMIceTipCommentPanel',
	#superclass : 'IceTipCommentPanel',
	#category : 'AI4Iceberg',
	#package : 'AI4Iceberg'
}

{ #category : 'accessing' }
LLMIceTipCommentPanel >> appendResultText: message [

	commentText text: commentText text , message
]

{ #category : 'accessing' }
LLMIceTipCommentPanel >> buildPrompt [

	^ String streamContents: [ :stream |
			  self repositoryModel workingCopyDiff treeRoots collect: [ :root |
					  root allChildrenDo: [ :child |
							  stream
								  << 'On: ';
								  << child key;
								  << String lf.
							  child value printOnLLMQuery: stream.
							  stream << String lf.
							  stream << '---' ] ] ]
]

{ #category : 'accessing' }
LLMIceTipCommentPanel >> generateCommitMessage [
	"Generates a commit message using the Ollama API and displays it in the commentText."

	| prompt answer api |
	prompt := self buildPrompt.
	api := LLMAPI chat.
	api payload temperature: 0.7.
	api payload model: 'devstral'.
	api payload top_p: 0.9.
	api payload stream: true.
	api payload messages: {
			(LLMAPIChatObjectMessage
				 role: 'system'
				 content: 'You are a good developer. Based on the context code diff. Write a commit message. No additionnal comment. Only commit message.').
			(LLMAPIChatObjectMessage role: 'user' content: prompt) }.
	answer := api performRequest.

	self appendResultText: answer
]

{ #category : 'initialization' }
LLMIceTipCommentPanel >> initializePresenters [

	super initializePresenters.
	optionsButton add: (self newToolbarButton
			 icon: (self application iconNamed: #smallLeftFlush);
			 label: 'Generate commit message';
			 help: 'Generate the commit message based on the work';
			 action: [ self generateCommitMessage ];
			 yourself)
]
