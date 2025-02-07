"Pharo script to initialize my environment when launching GT"

LePageToolContentTreeElement showIncomingReferencesInlined.	"Pharo script to initialize my environment when launching GT"
GtWorldElement allInstances first space extent: 2000 @ 1000.
BlGlutinHostSpace zoomFactor: 1.2.
([ Smalltalk globals
	at: #BaselineOfONHome
	ifAbsent: [ Metacello new
			repository: 'github://onierstrasz/ONHome:main/src';
			baseline: 'ONHome';
			load.
		#BaselineOfONHome asClass loadLepiter.
		Smalltalk saveSession ].
[ Smalltalk globals
	at: #BaselineOfONGtExperiments
	ifAbsent: [ Metacello new
			repository: 'github://onierstrasz/on-gt-experiments:main/src';
			baseline: 'ONGtExperiments';
			load.
		#BaselineOfONGtExperiments asClass loadLepiter ].
Smalltalk saveSession ] ] asAsyncFuture
	await: (AsyncFutureExecutionConfiguration new customGroup: #Lepiter))
	then: [ IceGitCliPlatform current install.
		IceGitCliPlatform current signCommits: true.
		IceGitCliPlatform current enabledLogging.
		GtIceRepositorySwitcher switchAll.
		GtGitHubTokenHolder exampleReadAndCacheTokenFromFile ]
	otherwise: [ :ex | self inform: 'Loading ONHome failed.' ]