Extension { #name : 'IceRemoval' }

{ #category : '*AI4Iceberg' }
IceRemoval >> printOnLLMQuery: aWriteStream [

	aWriteStream
		<< 'deletions:';
		<< String lf.
	aWriteStream << self rightContents 
]
