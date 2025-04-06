tweakUI := [ LePageToolContentTreeElement showIncomingReferencesInlined.
	"GtWorldElement allInstances first space extent: 2000 @ 1200."
	BlGlutinHostSpace zoomFactor: 1.2 ].

loadHome := [ Smalltalk globals
		at: #BaselineOfONHome
		ifAbsent: [ Metacello new
				repository: 'github://onierstrasz/ONHome:main/src';
				baseline: 'ONHome';
				load.
			#BaselineOfONHome asClass loadLepiter ] ].

loadExperiments := [ Smalltalk globals
		at: #BaselineOfONGtExperiments
		ifAbsent: [ Metacello new
				repository: 'github://onierstrasz/on-gt-experiments:main/src';
				baseline: 'ONGtExperiments';
				load.
			#BaselineOfONGtExperiments asClass loadLepiter ] ].

useGitCLI := [ IceGitCliPlatform current install.
	IceGitCliPlatform current signCommits: true.
	IceGitCliPlatform current enabledLogging.
	GtIceRepositorySwitcher switchAll.
	GtGitHubTokenHolder exampleReadAndCacheTokenFromFile ].

tweakUI value.
useGitCLI value.

'./pharo-local/iceberg/feenkcom' asFileReference exists
	ifTrue: [ loadHome value.
		loadExperiments value.
		Smalltalk saveSession ]
	ifFalse: [ ([ loadHome value.
		loadExperiments value ] asAsyncFuture
			await: (AsyncFutureExecutionConfiguration new customGroup: #Lepiter))
			then: [ Smalltalk saveSession ]
			otherwise: [ :ex | self inform: 'Loading ONHome failed.' ] ]