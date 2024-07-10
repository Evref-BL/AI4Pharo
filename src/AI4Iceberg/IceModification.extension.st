Extension { #name : 'IceModification' }

{ #category : '*AI4Iceberg' }
IceModification >> printOnLLMQuery: aWriteStream [

	aWriteStream
		<< 'modification from:';
		<< String lf.
	aWriteStream
		<< self oldDefinition sourceCode;
		<< String lf.
	aWriteStream
		<< 'to:';
		<< String lf.
	aWriteStream
		<< self definition sourceCode;
		<< String lf
]
