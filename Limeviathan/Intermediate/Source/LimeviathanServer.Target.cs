using UnrealBuildTool;

public class LimeviathanServerTarget : TargetRules
{
	public LimeviathanServerTarget(TargetInfo Target) : base(Target)
	{
		DefaultBuildSettings = BuildSettingsVersion.V3;
		IncludeOrderVersion = EngineIncludeOrderVersion.Latest;
		Type = TargetType.Server;
		ExtraModuleNames.Add("Limeviathan");
	}
}
