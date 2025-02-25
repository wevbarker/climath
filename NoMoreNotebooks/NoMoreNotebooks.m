(*===================*)
(*  NoMoreNotebooks  *)
(*===================*)

BeginPackage["NoMoreNotebooks`",{"JLink`"}];
xAct`NoMoreNotebooks`Private`$InstallDirectory=Select[FileNameJoin[{#,"NoMoreNotebooks"}]&/@$Path,DirectoryQ][[1]];
Run@("echo -e $(cat "<>FileNameJoin@{xAct`NoMoreNotebooks`Private`$InstallDirectory,"Logo.txt"}<>")");

(*========================================*)
(*  Declaration of functions and options  *)
(*========================================*)

Ignite::usage="Ignite[]";
Douse::usage="Douse[]";
Burn::usage="Burn[Expr_String]";
Smother::usage="Smother[]";
Singe::usage="Singe[]";
VimJ::usage="VimJ[]";

(*====================*)
(*  Global variables  *)
(*====================*)

$NonInteractive::usage="$NonInteractive";

Begin["NoMoreNotebooks`Private`"];

(*====================*)
(*  Global variables  *)
(*====================*)

$NonInteractive=False;
$TargetKernelName="NoMoreNotebooks";
If[$VersionNumber<=14,
	$FrontEndLaunchCommand="/usr/local/bin/mathematica -mathlink -linkmode launch -linkname 'math -mathlink'";,
	$FrontEndLaunchCommand="/usr/local/bin/wolframnb -mathlink -linkmode launch -linkname 'math -mathlink'";
];
$DeletePauseTime=10;

(*==================*)
(*  Implementation  *)
(*==================*)

ShowStatus[Expr_?StringQ]:=Module[{},	
	Run@("echo -e \"\\e[1;34;42m NoMoreNotebooks: \\e[1;30;42m"<>Expr<>" \\e[0m\"");
];

Ignite[]:=Module[{$FrontEndConnected},
	ShowStatus@"Connecting the FrontEnd...";
	$FrontEndConnected=ConnectToFrontEnd[];
	If[$FrontEndConnected,ShowStatus@"FrontEnd connected.";,
		ShowStatus@"FrontEnd not connected.";Abort[]
	];
	If[$VersionNumber<=14,
		$TargetNotebookObject=UsingFrontEnd@CreateNotebook[WindowElements->{}];,
		(*This stopped working when we switched to Arch, so it needs further investigation*)
		(*$TargetNotebookObject=UsingFrontEnd@CreateNotebook[WindowElements->{},Evaluator->$TargetKernelName];,*)
		$TargetNotebookObject=UsingFrontEnd@CreateNotebook[WindowElements->{}];
	];
	UsingFrontEnd@SetOptions[$TargetNotebookObject,Background->RGBColor@"#07242c"];
	UsingFrontEnd@SetOptions[$TargetNotebookObject,FontColor->RGBColor@"#c4c7c7"];
	UsingFrontEnd@(CurrentValue[$FrontEnd,WindowToolbars]={});
	UsingFrontEnd@SetOptions[$FrontEnd,IgnoreSpellCheck->True];

];

Douse[]:=UsingFrontEnd@NotebookClose@$TargetNotebookObject;

Burn[FileName_]:=UsingFrontEnd@Module[{FullFileName},	
	FullFileName=FileNameJoin@{Directory[],FileName};
	ShowStatus@("Running "<>FullFileName<>"...");
	$TargetNotebookObject~NotebookSave~(FullFileName~StringReplace~{".m"->".nb"});
	SelectionMove[$TargetNotebookObject,All,Notebook];
	NotebookDelete@$TargetNotebookObject;
	$TargetNotebookObject~NotebookWrite~(ToBoxes@(Defer@Quit[]));
	SelectionMove[$TargetNotebookObject,All,Notebook];
	SelectionEvaluate@$TargetNotebookObject;
	SelectionMove[$TargetNotebookObject,All,Notebook];
	NotebookDelete@$TargetNotebookObject;
	$TargetNotebookObject~NotebookWrite~(ToBoxes@(Defer@Get@FullFileName/.OwnValues@FullFileName));
	SelectionMove[$TargetNotebookObject,All,Notebook];
	SelectionEvaluate@$TargetNotebookObject;
	If[$NonInteractive,
		While[(FileExistsQ@(FullFileName~StringReplace~{".m"->".nb"})),Pause@1];
	,
		SelectionMove[$TargetNotebookObject,Before,Notebook];
		SelectionMove[$TargetNotebookObject,Next,Cell];
		Pause@$DeletePauseTime;
		NotebookDelete[$TargetNotebookObject];
		SelectionMove[$TargetNotebookObject,After,Notebook];
		SelectionMove[$TargetNotebookObject,Previous,Cell];
	];
	ShowStatus@"Run complete.";
];

Smother[]:=UsingFrontEnd@FrontEndExecute@FrontEndToken@"EvaluatorAbort";

(*This prints the notebook to an output file*)
Singe[FileName_]:=UsingFrontEnd@Module[{FullFileName},	
	FullFileName=FileNameJoin@{Directory[],FileName};
	ShowStatus@("Saving "<>FullFileName<>"...");
	$TargetNotebookObject~NotebookPrint~FullFileName;
];

VimJ[]:=UsingFrontEnd@SelectionMove[$TargetNotebookObject,Next,Cell];
(*VimJ[]:=UsingFrontEnd@SelectionMove[$TargetNotebookObject,Next,Cell,5,AutoScroll->True];*)

End[];
EndPackage[];
