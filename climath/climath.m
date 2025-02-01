(*===========*)
(*  climath  *)
(*===========*)

BeginPackage["climath`",{"JLink`","xAct`xPlain`"}];
xAct`climath`Private`$InstallDirectory=Select[FileNameJoin[{#,"climath"}]&/@$Path,DirectoryQ][[1]];
Run@("echo -e $(cat "<>FileNameJoin@{xAct`climath`Private`$InstallDirectory,"Logo.txt"}<>")");

(*========================================*)
(*  Declaration of functions and options  *)
(*========================================*)

Ignite::usage="Ignite[]";
Douse::usage="Douse[]";
Burn::usage="Burn[Expr_String]";
Smother::usage="Smother[]";
VimJ::usage="VimJ[]";

(*====================*)
(*  Global variables  *)
(*====================*)

$NonInteractive::usage="$NonInteractive";

Begin["climath`Private`"];

(*====================*)
(*  Global variables  *)
(*====================*)

$NonInteractive=False;
$TargetKernelName="climath";
(*$FrontEndLaunchCommand = "/usr/local/bin/wolframnb";*)
$FrontEndLaunchCommand = "/usr/local/bin/wolframnb -mathlink -linkmode launch -linkname 'math -mathlink'";
$DeletePauseTime=10;

(*==================*)
(*  Implementation  *)
(*==================*)

Ignite[]:=Module[{$FrontEndConnected},
	Comment@"Igniting the FrontEnd...";
	$FrontEndConnected=ConnectToFrontEnd[];
	If[$FrontEndConnected,Comment@"FrontEnd ignited.";,
		Comment@"FrontEnd not ignited.";Abort[]];
	(*The use of the climath kernel name began to cause problems in 14.1*)
	$TargetNotebookObject=UsingFrontEnd@CreateNotebook[WindowElements->{}];
	(*$TargetNotebookObject=UsingFrontEnd@CreateNotebook[Evaluator->$TargetKernelName];*)
	UsingFrontEnd@SetOptions[$TargetNotebookObject,Background->xAct`xPlain`Private`$NBlack];
	UsingFrontEnd@SetOptions[$TargetNotebookObject,FontColor->xAct`xPlain`Private`$NWhite];
	UsingFrontEnd@(CurrentValue[$FrontEnd,WindowToolbars]={});
	UsingFrontEnd@SetOptions[$FrontEnd,IgnoreSpellCheck->True];
];

Douse[]:=UsingFrontEnd@NotebookClose@$TargetNotebookObject;

Burn[FileName_]:=UsingFrontEnd@Module[{FullFileName},	
	FullFileName=FileNameJoin@{Directory[],FileName};
	Comment@("Running the script at "<>FullFileName<>"...");
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
	Comment@"Script executed.";
];

Smother[]:=UsingFrontEnd@FrontEndExecute@FrontEndToken@"EvaluatorAbort";

VimJ[]:=UsingFrontEnd@SelectionMove[$TargetNotebookObject,Next,Cell];
(*VimJ[]:=UsingFrontEnd@SelectionMove[$TargetNotebookObject,Next,Cell,5,AutoScroll->True];*)

End[];
EndPackage[];
