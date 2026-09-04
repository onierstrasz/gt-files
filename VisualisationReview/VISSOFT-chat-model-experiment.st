Object subclass: #VISSOFTAuthorExamples	instanceVariableNames: ''	classVariableNames: ''	package: 'VISSOFT-Examples'!!VISSOFTAuthorExamples commentStamp: nil prior: 0!Executable examples for VISSOFTAuthor.!!VISSOFTAuthorExamples methodsFor: 'examples' stamp: '9/2/2026 10:45'!author
	<gtExample>
	| author |
	author := VISSOFTDatasetExamples new dataset authorNamed: 'Sajaniemi, J.'.
	self assert: author isNotNil.
	self assert: author papers size equals: 3.
	^ author! !Object subclass: #VISSOFTDatasetExamples	instanceVariableNames: ''	classVariableNames: ''	package: 'VISSOFT-Examples'!!VISSOFTDatasetExamples commentStamp: nil prior: 0!Executable examples for VISSOFTDataset.!!VISSOFTDatasetExamples methodsFor: 'examples' stamp: '9/2/2026 10:45'!dataset
	<gtExample>
	| dataset |
	dataset := VISSOFTDataset fromAllCSV.
	self assert: dataset papers size equals: 346.
	^ dataset! !!VISSOFTDatasetExamples methodsFor: 'examples' stamp: '9/2/2026 10:45'!papersByYear
	<gtExample>
	| dataset |
	dataset := self dataset.
	self assert: (dataset papersByYear at: 2003) size equals: 40.
	^ dataset papersByYear! !Object subclass: #VISSOFTPaperTypeExamples	instanceVariableNames: ''	classVariableNames: ''	package: 'VISSOFT-Examples'!!VISSOFTPaperTypeExamples commentStamp: nil prior: 0!Executable examples for VISSOFTPaperType.!!VISSOFTPaperTypeExamples methodsFor: 'examples' stamp: '9/2/2026 10:45'!paperType
	<gtExample>
	| type |
	type := VISSOFTDatasetExamples new dataset typeNamed: 'Design Study'.
	self assert: type isNotNil.
	self assert: type papers size equals: 65.
	^ type! !Object subclass: #VISSOFTPaperExamples	instanceVariableNames: ''	classVariableNames: ''	package: 'VISSOFT-Examples'!!VISSOFTPaperExamples commentStamp: nil prior: 0!Executable examples for VISSOFTPaper.!!VISSOFTPaperExamples methodsFor: 'examples' stamp: '9/2/2026 10:45'!paper
	<gtExample>
	| paper |
	paper := VISSOFTDatasetExamples new dataset papers first.
	self assert: paper id equals: 1.
	self assert: paper title equals: 'Program animation based on the roles of variables'.
	^ paper! !!VISSOFTPaperExamples methodsFor: 'examples' stamp: '9/2/2026 10:45'!paperAuthors
	<gtExample>
	| paper |
	paper := self paper.
	self assert: paper authors size equals: 2.
	self assert: paper authors first name equals: 'Sajaniemi, J.'.
	^ paper authors! !Object subclass: #VISSOFTPaper	instanceVariableNames: 'data dataset'	classVariableNames: ''	package: 'VISSOFT-Model'!!VISSOFTPaper commentStamp: nil prior: 0!Models one software-visualisation publication described by a CSV row.!!VISSOFTPaper methodsFor: 'instance creation' stamp: '9/2/2026 10:45'!data: aDictionary dataset: aDataset
	^ self new data: aDictionary; dataset: aDataset; yourself! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 10:45'!data: aDictionary
	data := aDictionary! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 10:45'!dataset: aDataset
	dataset := aDataset! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 10:45'!id
	^ (data at: 'ID') asNumber! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 10:45'!title
	^ data at: 'Title'! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 10:45'!year
	^ (data at: 'Paper Year') asNumber! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 10:45'!typeName
	^ data at: 'Type'! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 10:45'!authors
	^ self authorNames collect: [ :each | dataset authorNamed: each ]! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 10:45'!authorNames
	^ ((data keys select: [ :each | each endsWith: 'Author' ])
		collect: [ :key | data at: key ]) reject: #isNil! !!VISSOFTPaper methodsFor: 'printing' stamp: '9/2/2026 10:45'!printOn: aStream
	aStream nextPutAll: self title! !!VISSOFTPaper methodsFor: 'views' stamp: '9/2/2026 10:45'!gtAuthorsFor: aView
	<gtView>
	^ aView columnedList
		title: 'Authors';
		priority: 10;
		items: [ self authors ];
		column: 'Name' text: #name;
		column: 'Papers' text: [ :each | each papers size ] width: 70! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!VISSOFTPaper class	instanceVariableNames: ''!!VISSOFTPaper class commentStamp: nil prior: 0!Models one software-visualisation publication described by a CSV row.!!VISSOFTPaper class methodsFor: 'instance creation' stamp: '9/2/2026 10:45'!data: aDictionary dataset: aDataset
	^ self new
		data: aDictionary;
		dataset: aDataset;
		yourself! !Object subclass: #VISSOFTAuthor	instanceVariableNames: 'name papers'	classVariableNames: ''	package: 'VISSOFT-Model'!!VISSOFTAuthor commentStamp: nil prior: 0!Models an author and the papers attributed to that author.!!VISSOFTAuthor methodsFor: 'accessing' stamp: '9/2/2026 10:45'!name: aString
	name := aString! !!VISSOFTAuthor methodsFor: 'accessing' stamp: '9/2/2026 10:45'!papers: aCollection
	papers := aCollection! !!VISSOFTAuthor methodsFor: 'accessing' stamp: '9/2/2026 10:45'!name
	^ name! !!VISSOFTAuthor methodsFor: 'accessing' stamp: '9/2/2026 10:45'!papers
	^ papers! !!VISSOFTAuthor methodsFor: 'printing' stamp: '9/2/2026 10:45'!printOn: aStream
	aStream nextPutAll: name! !!VISSOFTAuthor methodsFor: 'views' stamp: '9/2/2026 10:45'!gtPapersFor: aView
	<gtView>
	^ aView columnedList
		title: 'Papers';
		priority: 10;
		items: [ self papers ];
		column: 'Year' text: #year width: 60;
		column: 'Title' text: #title;
		column: 'Type' text: #typeName width: 120! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!VISSOFTAuthor class	instanceVariableNames: ''!!VISSOFTAuthor class commentStamp: nil prior: 0!Models an author and the papers attributed to that author.!!VISSOFTAuthor class methodsFor: 'instance creation' stamp: '9/2/2026 10:45'!name: aString papers: aCollection
	^ self new name: aString; papers: aCollection; yourself! !Object subclass: #VISSOFTDataset	instanceVariableNames: 'papers authors types'	classVariableNames: ''	package: 'VISSOFT-Model'!!VISSOFTDataset commentStamp: nil prior: 0!Models the VISSOFT CSV dataset and provides navigable collections of its papers, authors, and paper types.!!VISSOFTDataset methodsFor: 'initialization' stamp: '9/2/2026 10:45'!initializeFromRows: rows
	papers := rows collect: [ :each | VISSOFTPaper data: each dataset: self ].
	authors := nil.
	types := nil! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 10:45'!papers
	^ papers! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 10:45'!papersByYear
	^ (papers groupedBy: #year) asDictionary! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 10:45'!authors
	^ authors ifNil: [
		| papersByAuthor |
		papersByAuthor := Dictionary new.
		papers do: [ :paper |
			paper authorNames do: [ :authorName |
				(papersByAuthor at: authorName ifAbsentPut: [ OrderedCollection new ]) add: paper ] ].
		authors := (papersByAuthor associations collect: [ :each | VISSOFTAuthor name: each key papers: each value ])
			asSortedCollection: [ :a :b | a name < b name ] ]! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 10:45'!types
	^ types ifNil: [ types := (papers groupedBy: #typeName) associations collect: [ :each | VISSOFTPaperType name: each key papers: each value ] ]! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 10:45'!authorNamed: aString
	^ self authors detect: [ :each | each name = aString ] ifNone: [ nil ]! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 10:45'!typeNamed: aString
	^ self types detect: [ :each | each name = aString ] ifNone: [ nil ]! !!VISSOFTDataset methodsFor: 'printing' stamp: '9/2/2026 10:45'!printOn: aStream
	aStream nextPutAll: 'VISSOFT dataset ('; print: papers size; nextPutAll: ' papers)'.! !!VISSOFTDataset methodsFor: 'views' stamp: '9/2/2026 10:45'!gtPapersFor: aView
	<gtView>
	^ aView columnedList
		title: 'Papers';
		priority: 10;
		items: [ self papers ];
		column: 'Year' text: #year width: 60;
		column: 'Title' text: #title;
		column: 'Type' text: #typeName width: 120! !!VISSOFTDataset methodsFor: 'views' stamp: '9/2/2026 10:45'!gtPapersByYearFor: aView
	<gtView>
	^ aView forward
		title: 'Papers by year';
		priority: 20;
		object: [ self papersByYear ];
		view: #gtItemsFor:! !!VISSOFTDataset methodsFor: 'views' stamp: '9/2/2026 10:45'!gtAuthorsFor: aView
	<gtView>
	^ aView columnedList
		title: 'Authors';
		priority: 30;
		items: [ self authors ];
		column: 'Author' text: #name;
		column: 'Papers' text: [ :each | each papers size ] width: 70! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!VISSOFTDataset class	instanceVariableNames: ''!!VISSOFTDataset class commentStamp: nil prior: 0!Models the VISSOFT CSV dataset and provides navigable collections of its papers, authors, and paper types.!!VISSOFTDataset class methodsFor: 'instance creation' stamp: '9/2/2026 10:45'!fromCSV: aFileReference
	| rows dataset |
	rows := CSVParser parseFileWithHeader: aFileReference pathString.
	dataset := self new.
	dataset initializeFromRows: rows.
	^ dataset! !!VISSOFTDataset class methodsFor: 'instance creation' stamp: '9/2/2026 10:45'!fromAllCSV
	^ self fromCSV: (FileLocator gtResource / 'feenkcom/gtoolkit-demos/data/visualisation-review/dataset-review-vissoft-all.csv')! !Object subclass: #VISSOFTPaperType	instanceVariableNames: 'name papers'	classVariableNames: ''	package: 'VISSOFT-Model'!!VISSOFTPaperType commentStamp: nil prior: 0!Models a paper type and the papers classified with it.!!VISSOFTPaperType methodsFor: 'accessing' stamp: '9/2/2026 10:45'!name: aString
	name := aString! !!VISSOFTPaperType methodsFor: 'accessing' stamp: '9/2/2026 10:45'!papers: aCollection
	papers := aCollection! !!VISSOFTPaperType methodsFor: 'accessing' stamp: '9/2/2026 10:45'!name
	^ name! !!VISSOFTPaperType methodsFor: 'accessing' stamp: '9/2/2026 10:45'!papers
	^ papers! !!VISSOFTPaperType methodsFor: 'printing' stamp: '9/2/2026 10:45'!printOn: aStream
	aStream nextPutAll: name! !!VISSOFTPaperType methodsFor: 'views' stamp: '9/2/2026 10:45'!gtPapersFor: aView
	<gtView>
	^ aView columnedList
		title: 'Papers';
		priority: 10;
		items: [ self papers ];
		column: 'Year' text: #year width: 60;
		column: 'Title' text: #title! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!VISSOFTPaperType class	instanceVariableNames: ''!!VISSOFTPaperType class commentStamp: nil prior: 0!Models a paper type and the papers classified with it.!!VISSOFTPaperType class methodsFor: 'instance creation' stamp: '9/2/2026 10:45'!name: aString papers: aCollection
	^ self new name: aString; papers: aCollection; yourself! !