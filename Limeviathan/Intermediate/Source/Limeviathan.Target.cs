using UnrealBuildTool;

public class LimeviathanTarget : TargetRules
{
	public LimeviathanTarget(TargetInfo Target) : base(Target)
	{
		DefaultBuildSettings = BuildSettingsVersion.V3;
		IncludeOrderVersion = EngineIncludeOrderVersion.Latest;
		Type = TargetType.Game;
		ExtraModuleNames.Add("Limeviathan");
	}
}
