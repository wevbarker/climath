(*===========*)
(*  climath  *)
(*===========*)

BeginPackage["climath`",{"JLink`"}];

(*========================================*)
(*  Declaration of functions and options  *)
(*========================================*)

Ignite::usage="Ignite[]";
Douse::usage="Douse[]";
Burn::usage="Burn[Expr_String]";

Begin["climath`Private`"];

(*====================*)
(*  Global variables  *)
(*====================*)

$TargetKernelName="climath";
$FrontEndLaunchCommand = "/usr/local/bin/mathematica -mathlink -linkmode launch -linkname 'math -mathlink'";

Ignite[]:=Module[{$FrontEndConnected},
	$FrontEndConnected=ConnectToFrontEnd[];
	If[$FrontEndConnected,Print["FrontEnd connected."];,
		Print["FrontEnd not connected."];Abort[]];
	$TargetNotebookObject=UsingFrontEnd@CreateNotebook[Evaluator->$TargetKernelName];
$FrontEndConnected];

Douse[]:=UsingFrontEnd@NotebookClose@$TargetNotebookObject;

Burn[FileName_]:=UsingFrontEnd@Module[{FullFileName},
	FullFileName=FileNameJoin@{Directory[],FileName};
	Print@FullFileName;
	$TargetNotebookObject~NotebookSave~(FullFileName~StringReplace~{".m"->".nb"});
	SelectionMove[$TargetNotebookObject,All,Notebook];
	NotebookDelete@$TargetNotebookObject;
	Print@(MakeBoxes@(Defer@Get@FullFileName/.OwnValues@FullFileName));
	Print@(ToBoxes@(Defer@Get@FullFileName/.OwnValues@FullFileName));
	$TargetNotebookObject~NotebookWrite~(ToBoxes@(Defer@Get@FullFileName/.OwnValues@FullFileName));
	SelectionMove[$TargetNotebookObject,All,Notebook];
	SelectionEvaluate@$TargetNotebookObject;
	SelectionMove[$TargetNotebookObject,Before,Notebook];
	SelectionMove[$TargetNotebookObject,Next,Cell];
	Pause[10];
	NotebookDelete[$TargetNotebookObject];
];

End[];
EndPackage[];
