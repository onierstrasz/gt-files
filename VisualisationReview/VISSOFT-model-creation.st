Object subclass: #VISSOFTPaper	instanceVariableNames: 'dataset data'	classVariableNames: ''	package: 'VISSOFT-Model'!!VISSOFTPaper commentStamp: nil prior: 0!A paper in a VISSOFT dataset.!!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 14:51'!data
	^ data! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 14:51'!data: aDictionary
	data := aDictionary! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 14:51'!dataset
	^ dataset! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 14:51'!dataset: aDataset
	dataset := aDataset! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 14:51'!id
	^ (data at: 'ID') asNumber! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 14:51'!title
	^ data at: 'Title'! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 14:51'!year
	^ data at: 'Year'! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 14:51'!type
	^ data at: 'Type'! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 14:51'!authorNames
	^ (self authorFields collect: [ :field | data at: field ])
		select: #isNotEmpty
		thenCollect: [ :name | name trimBoth: [ :character | character = $" ] ]! !!VISSOFTPaper methodsFor: 'accessing' stamp: '9/2/2026 14:51'!authors
	^ VISSOFTAuthorGroup withAll: (self authorNames collect: [ :name | dataset authorNamed: name ])! !!VISSOFTPaper methodsFor: 'constants' stamp: '9/2/2026 14:51'!authorFields
	^ #('First Author' 'Second Author' 'Third Author' 'Fourth Author' 'Fifth Author' 'Sixth Author' 'Seven Author' 'Eighth Author' 'Nineth Author' 'Tenth Author' 'Eleventh Author' 'Twelfth Author')! !!VISSOFTPaper methodsFor: 'testing' stamp: '9/2/2026 14:51'!isSelected
	^ dataset selectedRows anySatisfy: [ :row | (row at: 'ID') asNumber = self id ]! !!VISSOFTPaper methodsFor: 'printing' stamp: '9/2/2026 14:51'!printOn: aStream
	aStream nextPutAll: self title! !!VISSOFTPaper methodsFor: 'views' stamp: '9/2/2026 14:51'!gtAuthorsFor: aView
	<gtView>
	^ aView forward
		title: 'Authors';
		priority: 10;
		object: [ self authors ];
		view: #gtItemsFor:! !!VISSOFTPaper methodsFor: 'views' stamp: '9/2/2026 14:51'!gtSummaryFor: aView
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 5;
		items: [ {{'Year'. self year}. {'Type'. self type}. {'Authors'. self authorNames size}} ];
		column: 'Property' text: #first;
		column: 'Value' text: #second! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!VISSOFTPaper class	instanceVariableNames: ''!!VISSOFTPaper class commentStamp: nil prior: 0!A paper in a VISSOFT dataset.!!VISSOFTPaper class methodsFor: 'instance creation' stamp: '9/2/2026 14:51'!for: aDictionary in: aDataset
	^ self new
		data: aDictionary;
		dataset: aDataset;
		yourself! !Object subclass: #VISSOFTPaperType	instanceVariableNames: 'name papers'	classVariableNames: ''	package: 'VISSOFT-Model'!!VISSOFTPaperType commentStamp: nil prior: 0!A named category of papers in a VISSOFT dataset.!!VISSOFTPaperType methodsFor: 'initialization' stamp: '9/2/2026 14:51'!initialize
	super initialize.
	papers := OrderedCollection new! !!VISSOFTPaperType methodsFor: 'accessing' stamp: '9/2/2026 14:51'!name
	^ name! !!VISSOFTPaperType methodsFor: 'accessing' stamp: '9/2/2026 14:51'!name: aString
	name := aString! !!VISSOFTPaperType methodsFor: 'accessing' stamp: '9/2/2026 14:51'!papers
	^ VISSOFTPaperGroup withAll: papers! !!VISSOFTPaperType methodsFor: 'accessing' stamp: '9/2/2026 14:51'!addPaper: aPaper
	papers add: aPaper! !!VISSOFTPaperType methodsFor: 'printing' stamp: '9/2/2026 14:51'!printOn: aStream
	aStream nextPutAll: name! !!VISSOFTPaperType methodsFor: 'views' stamp: '9/2/2026 14:51'!gtPapersFor: aView
	<gtView>
	^ aView forward
		title: 'Papers';
		object: [ self papers ];
		view: #gtItemsFor:! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!VISSOFTPaperType class	instanceVariableNames: ''!!VISSOFTPaperType class commentStamp: nil prior: 0!A named category of papers in a VISSOFT dataset.!!VISSOFTPaperType class methodsFor: 'instance creation' stamp: '9/2/2026 14:51'!named: aString
	^ self new name: aString; yourself! !Object subclass: #VISSOFTDataset	instanceVariableNames: 'allRows selectedRows paperById authorByName'	classVariableNames: ''	package: 'VISSOFT-Model'!!VISSOFTDataset commentStamp: nil prior: 0!A software-visualization review dataset loaded from its two CSV files.!!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 14:51'!allRows
	^ allRows! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 14:51'!allRows: aCollection
	allRows := aCollection! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 14:51'!selectedRows
	^ selectedRows! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 14:51'!selectedRows: aCollection
	selectedRows := aCollection! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 14:51'!papers
	^ VISSOFTPaperGroup withAll: self paperById values! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 14:51'!selectedPapers
	^ VISSOFTPaperGroup withAll: (self papers select: #isSelected)! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 14:51'!authors
	^ VISSOFTAuthorGroup withAll: (self authorByName values sorted: [ :left :right | left name <= right name ])! !!VISSOFTDataset methodsFor: 'accessing' stamp: '9/2/2026 14:51'!paperTypes
	| types |
	types := Dictionary new.
	self papers do: [ :paper |
		(types at: paper type ifAbsentPut: [ VISSOFTPaperType named: paper type ]) addPaper: paper ].
	^ types values asArray sorted: [ :left :right | left name <= right name ]! !!VISSOFTDataset methodsFor: 'private' stamp: '9/2/2026 14:51'!paperById
	^ paperById ifNil: [
		paperById := ((allRows collect: [ :row | VISSOFTPaper for: row in: self ]) collect: [ :paper | paper id -> paper ]) asDictionary ]! !!VISSOFTDataset methodsFor: 'private' stamp: '9/2/2026 14:51'!authorByName
	^ authorByName ifNil: [
		authorByName := Dictionary new.
		self papers do: [ :paper |
			paper authorNames do: [ :authorName |
				(authorByName at: authorName ifAbsentPut: [ VISSOFTAuthor named: authorName in: self ]) addPaper: paper ] ].
		authorByName ]! !!VISSOFTDataset methodsFor: 'querying' stamp: '9/2/2026 14:51'!paperWithId: anId
	^ self paperById at: anId! !!VISSOFTDataset methodsFor: 'querying' stamp: '9/2/2026 14:51'!authorNamed: aName
	^ self authorByName at: aName! !!VISSOFTDataset methodsFor: 'querying' stamp: '9/2/2026 14:51'!papersInYear: aYear
	^ VISSOFTPaperGroup withAll: (self papers select: [ :paper | paper year = aYear asString ])! !!VISSOFTDataset methodsFor: 'views' stamp: '9/2/2026 14:51'!gtPapersFor: aView
	<gtView>
	^ aView forward
		title: 'Papers';
		priority: 10;
		object: [ self papers ];
		view: #gtItemsFor:! !!VISSOFTDataset methodsFor: 'views' stamp: '9/2/2026 14:51'!gtPapersByYearFor: aView
	<gtView>
	^ aView list
		title: 'Papers by year';
		priority: 20;
		items: [ (self papers collect: #year) asSet asArray sorted ];
		itemText: #asString;
		send: [ :year | self papersInYear: year ]! !!VISSOFTDataset methodsFor: 'views' stamp: '9/2/2026 14:51'!gtAuthorsFor: aView
	<gtView>
	^ aView forward
		title: 'Authors';
		priority: 30;
		object: [ self authors ];
		view: #gtItemsFor:! !!VISSOFTDataset methodsFor: 'printing' stamp: '9/2/2026 14:51'!printOn: aStream
	aStream nextPutAll: 'VISSOFT dataset ('; print: self papers size; nextPutAll: ' papers)'! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!VISSOFTDataset class	instanceVariableNames: ''!!VISSOFTDataset class commentStamp: nil prior: 0!A software-visualization review dataset loaded from its two CSV files.!!VISSOFTDataset class methodsFor: 'instance creation' stamp: '9/2/2026 14:51'!fromResourceFolder
	| folder |
	folder := (FileLocator gtResource / 'feenkcom' / 'gtoolkit-demos' / 'data' / 'visualisation-review') asFileReference fileReference.
	^ self
		fromAllCSV: folder / 'dataset-review-vissoft-all.csv'
		selectedCSV: folder / 'dataset-review-vissoft-selected.csv'! !!VISSOFTDataset class methodsFor: 'instance creation' stamp: '9/2/2026 14:51'!fromAllCSV: anAllFile selectedCSV: aSelectedFile
	^ self new
		allRows: (CSV2JSON for: anAllFile contents) jsonObject;
		selectedRows: (CSV2JSON for: aSelectedFile contents) jsonObject;
		yourself! !Object subclass: #VISSOFTAuthor	instanceVariableNames: 'dataset name papers'	classVariableNames: ''	package: 'VISSOFT-Model'!!VISSOFTAuthor commentStamp: nil prior: 0!An author and the papers attributed to them.!!VISSOFTAuthor methodsFor: 'initialization' stamp: '9/2/2026 14:51'!initialize
	super initialize.
	papers := OrderedCollection new! !!VISSOFTAuthor methodsFor: 'accessing' stamp: '9/2/2026 14:51'!name
	^ name! !!VISSOFTAuthor methodsFor: 'accessing' stamp: '9/2/2026 14:51'!name: aString
	name := aString! !!VISSOFTAuthor methodsFor: 'accessing' stamp: '9/2/2026 14:51'!dataset
	^ dataset! !!VISSOFTAuthor methodsFor: 'accessing' stamp: '9/2/2026 14:51'!dataset: aDataset
	dataset := aDataset! !!VISSOFTAuthor methodsFor: 'accessing' stamp: '9/2/2026 14:51'!papers
	^ VISSOFTPaperGroup withAll: papers! !!VISSOFTAuthor methodsFor: 'accessing' stamp: '9/2/2026 14:51'!addPaper: aPaper
	papers add: aPaper! !!VISSOFTAuthor methodsFor: 'printing' stamp: '9/2/2026 14:51'!printOn: aStream
	aStream nextPutAll: name! !!VISSOFTAuthor methodsFor: 'views' stamp: '9/2/2026 14:51'!gtPapersFor: aView
	<gtView>
	^ aView forward
		title: 'Papers';
		priority: 10;
		object: [ self papers ];
		view: #gtItemsFor:! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!VISSOFTAuthor class	instanceVariableNames: ''!!VISSOFTAuthor class commentStamp: nil prior: 0!An author and the papers attributed to them.!!VISSOFTAuthor class methodsFor: 'instance creation' stamp: '9/2/2026 14:51'!named: aName in: aDataset
	^ self new
		name: aName;
		dataset: aDataset;
		yourself! !Object subclass: #VISSOFTEntityGroup	uses: TGtGroupWithItems	instanceVariableNames: ''	classVariableNames: ''	package: 'VISSOFT-Model'!!VISSOFTEntityGroup commentStamp: nil prior: 0!A moldable collection wrapper for VISSOFT domain entities.!"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!VISSOFTEntityGroup class	uses: TGtGroupWithItems classTrait	instanceVariableNames: ''!!VISSOFTEntityGroup class commentStamp: nil prior: 0!A moldable collection wrapper for VISSOFT domain entities.!VISSOFTEntityGroup subclass: #VISSOFTAuthorGroup	instanceVariableNames: ''	classVariableNames: ''	package: 'VISSOFT-Model'!!VISSOFTAuthorGroup commentStamp: nil prior: 0!A moldable collection wrapper for authors.!!VISSOFTAuthorGroup methodsFor: 'views' stamp: '9/2/2026 14:51'!gtItemsFor: aView
	<gtView>
	^ aView columnedList
		title: 'Authors';
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Papers' text: [ :author | author papers size ] width: 70;
		actionUpdateButton! !VISSOFTEntityGroup subclass: #VISSOFTPaperGroup	instanceVariableNames: ''	classVariableNames: ''	package: 'VISSOFT-Model'!!VISSOFTPaperGroup commentStamp: nil prior: 0!A moldable collection wrapper for papers.!!VISSOFTPaperGroup methodsFor: 'views' stamp: '9/2/2026 14:51'!gtItemsFor: aView
	<gtView>
	^ aView columnedList
		title: 'Papers';
		items: [ self items ];
		column: 'Title' text: #title;
		column: 'Year' text: #year width: 60;
		column: 'Type' text: #type;
		actionUpdateButton! !Object subclass: #VISSOFTDatasetExamples	instanceVariableNames: ''	classVariableNames: ''	package: 'VISSOFT-Examples'!!VISSOFTDatasetExamples commentStamp: nil prior: 0!Examples for VISSOFTDataset.!!VISSOFTDatasetExamples methodsFor: 'examples' stamp: '9/2/2026 14:51'!dataset
	<gtExample>
	<return: #VISSOFTDataset>
	| dataset |
	dataset := VISSOFTDataset fromResourceFolder.
	self assert: dataset allRows size equals: 346.
	self assert: dataset selectedRows isNotEmpty.
	self assert: dataset papers size equals: dataset allRows size.
	^ dataset! !!VISSOFTDatasetExamples methodsFor: 'examples' stamp: '9/2/2026 14:51'!papersByYear
	<gtExample>
	<return: #VISSOFTPaperGroup>
	| papers |
	papers := self dataset papersInYear: '2003'.
	self assert: papers isNotEmpty.
	self assert: (papers allSatisfy: [ :paper | paper year = '2003' ]).
	^ papers! !!VISSOFTDatasetExamples methodsFor: 'examples' stamp: '9/2/2026 14:51'!authors
	<gtExample>
	<return: #VISSOFTAuthorGroup>
	| authors |
	authors := self dataset authors.
	self assert: authors isNotEmpty.
	self assert: (authors allSatisfy: [ :author | author papers isNotEmpty ]).
	^ authors! !VISSOFTDatasetExamples subclass: #VISSOFTAuthorExamples	instanceVariableNames: ''	classVariableNames: ''	package: 'VISSOFT-Examples'!!VISSOFTAuthorExamples commentStamp: nil prior: 0!Examples for VISSOFTAuthor.!!VISSOFTAuthorExamples methodsFor: 'examples' stamp: '9/2/2026 14:51'!author
	<gtExample>
	<return: #VISSOFTAuthor>
	| author |
	author := self dataset authors first.
	self assert: author name isNotEmpty.
	self assert: author papers isNotEmpty.
	^ author! !!VISSOFTAuthorExamples methodsFor: 'examples' stamp: '9/2/2026 14:51'!authorPapers
	<gtExample>
	<return: #VISSOFTPaperGroup>
	| author papers |
	author := self author.
	papers := author papers.
	self assert: (papers allSatisfy: [ :paper | paper authors includes: author ]).
	^ papers! !VISSOFTDatasetExamples subclass: #VISSOFTPaperTypeExamples	instanceVariableNames: ''	classVariableNames: ''	package: 'VISSOFT-Examples'!!VISSOFTPaperTypeExamples commentStamp: nil prior: 0!Examples for VISSOFTPaperType and the collection wrappers.!!VISSOFTPaperTypeExamples methodsFor: 'examples' stamp: '9/2/2026 14:51'!paperType
	<gtExample>
	<return: #VISSOFTPaperType>
	| paperType |
	paperType := self dataset paperTypes first.
	self assert: paperType name isNotEmpty.
	self assert: paperType papers isNotEmpty.
	^ paperType! !!VISSOFTPaperTypeExamples methodsFor: 'examples' stamp: '9/2/2026 14:51'!paperGroup
	<gtExample>
	<return: #VISSOFTPaperGroup>
	| group |
	group := VISSOFTPaperGroup withAll: { self dataset paperWithId: 1 }.
	self assert: group size equals: 1.
	self assert: group first id equals: 1.
	^ group! !!VISSOFTPaperTypeExamples methodsFor: 'examples' stamp: '9/2/2026 14:51'!authorGroup
	<gtExample>
	<return: #VISSOFTAuthorGroup>
	| group |
	group := VISSOFTAuthorGroup withAll: { self dataset authors first }.
	self assert: group size equals: 1.
	self assert: group first name isNotEmpty.
	^ group! !VISSOFTDatasetExamples subclass: #VISSOFTPaperExamples	instanceVariableNames: ''	classVariableNames: ''	package: 'VISSOFT-Examples'!!VISSOFTPaperExamples commentStamp: nil prior: 0!Examples for VISSOFTPaper.!!VISSOFTPaperExamples methodsFor: 'examples' stamp: '9/2/2026 14:51'!paper
	<gtExample>
	<return: #VISSOFTPaper>
	| paper |
	paper := self dataset paperWithId: 1.
	self assert: paper title isNotEmpty.
	self assert: paper year isNotEmpty.
	^ paper! !!VISSOFTPaperExamples methodsFor: 'examples' stamp: '9/2/2026 14:51'!paperAuthors
	<gtExample>
	<return: #VISSOFTAuthorGroup>
	| paper authors |
	paper := self paper.
	authors := paper authors.
	self assert: authors size equals: paper authorNames size.
	self assert: (authors allSatisfy: [ :author | author papers includes: paper ]).
	^ authors! !