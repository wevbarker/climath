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

(*====================*)
(*  Global variables  *)
(*====================*)

$NonInteractive::usage="$NonInteractive";

Begin["climath`Private`"];
$NonInteractive=False;

(*====================*)
(*  Global variables  *)
(*====================*)

$TargetKernelName="climath";
$FrontEndLaunchCommand = "/usr/local/bin/mathematica -mathlink -linkmode launch -linkname 'math -mathlink'";
$DeletePauseTime=10;

(*==================*)
(*  Implementation  *)
(*==================*)

Ignite[]:=Module[{$FrontEndConnected},
	Comment@"Igniting the FrontEnd...";
	$FrontEndConnected=ConnectToFrontEnd[];
	If[$FrontEndConnected,Comment@"FrontEnd ignited.";,
		Comment@"FrontEnd not ignited.";Abort[]];
	$TargetNotebookObject=UsingFrontEnd@CreateNotebook[Evaluator->$TargetKernelName];
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
	SelectionMove[$TargetNotebookObject,Before,Notebook];
	SelectionMove[$TargetNotebookObject,Next,Cell];
	Pause@$DeletePauseTime;
	NotebookDelete[$TargetNotebookObject];
	SelectionMove[$TargetNotebookObject,After,Notebook];
	$NonInteractive~If~While[!(FileExistsQ@(FullFileName~StringReplace~{".m"->".nb"})),Pause@1];
	Comment@"Script executed.";
];

Smother[]:=UsingFrontEnd@FrontEndExecute@FrontEndToken@"EvaluatorAbort";

End[];
EndPackage[];
