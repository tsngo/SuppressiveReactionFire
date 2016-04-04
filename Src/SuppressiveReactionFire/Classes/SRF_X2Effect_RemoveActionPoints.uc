class SRF_X2Effect_RemoveActionPoints extends X2Effect_PersistentStatChange;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit TargetUnit;

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);

	TargetUnit = XComGameState_Unit(kNewTargetState);
	if ( TargetUnit != none )
	{
		`RedScreen("APPLYING");
		//TargetUnit.ActionPoints.Length = 0;
		
	}
//	SourceUnit = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', ApplyEffectParameters.TargetStateObjectRef.ObjectID));
//	kNewTargetState.AddStateObject(TargetUnit);
}