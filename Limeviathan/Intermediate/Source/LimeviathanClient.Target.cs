using UnrealBuildTool;

public class LimeviathanClientTarget : TargetRules
{
	public LimeviathanClientTarget(TargetInfo Target) : base(Target)
	{
		DefaultBuildSettings = BuildSettingsVersion.V3;
		IncludeOrderVersion = EngineIncludeOrderVersion.Latest;
		Type = TargetType.Client;
		ExtraModuleNames.Add("Limeviathan");
	}
}
