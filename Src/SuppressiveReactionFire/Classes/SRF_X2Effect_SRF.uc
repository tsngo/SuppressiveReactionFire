class SRF_X2Effect_SRF extends X2Effect_PersistentStatChange;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit UnitState;
	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
	UnitState = XComGameState_Unit(kNewTargetState);
	`log("Added: " $ UnitState.GetFullName());
	`log("AIM: " $ UnitState.GetCurrentStat(eStat_Offense));
	`log("WILL: " $ UnitState.GetCurrentStat(eStat_Will));
}

simulated function OnEffectRemoved(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState, bool bCleansed, XComGameState_Effect RemovedEffectState)
{
	local XComGameState_Unit TargetUnit;
	
	TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	if (TargetUnit == none)
	{
		TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
		`assert(TargetUnit != none);
		`log("Removed: " $ TargetUnit.GetFullName());

	}
	super.OnEffectRemoved(ApplyEffectParameters, NewGameState, bCleansed, RemovedEffectState);
}
