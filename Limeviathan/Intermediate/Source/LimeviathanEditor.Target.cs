using UnrealBuildTool;

public class LimeviathanEditorTarget : TargetRules
{
	public LimeviathanEditorTarget(TargetInfo Target) : base(Target)
	{
		DefaultBuildSettings = BuildSettingsVersion.V3;
		IncludeOrderVersion = EngineIncludeOrderVersion.Latest;
		Type = TargetType.Editor;
		ExtraModuleNames.Add("Limeviathan");
	}
}
