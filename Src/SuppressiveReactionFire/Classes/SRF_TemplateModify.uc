class SRF_TemplateModify extends X2AmbientNarrativeCriteria;

static function array<X2DataTemplate> CreateTemplates()
{
	local X2DataTemplate DataTemplate;
	local X2AbilityTemplate AbilityTemplate;
	local X2AbilityToHitCalc_StandardAim StandardAim;
	local array<X2DataTemplate> Templates;
	local X2AbilityCost Cost;
	local X2AbilityCost_ReserveActionPoints ReservePoints;
	local bool hasReserve;
	
	Templates.Length = 0;

	foreach class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().IterateTemplates(DataTemplate, none)
	{
		AbilityTemplate = X2AbilityTemplate(DataTemplate);
		if (AbilityTemplate != none)
		{
			hasReserve = false;
			foreach AbilityTemplate.AbilityCosts(Cost)
			{
				ReservePoints = X2AbilityCost_ReserveActionPoints(Cost);
				if (ReservePoints != none) {
					hasReserve = true;
				}
			}
			StandardAim = X2AbilityToHitCalc_StandardAim(AbilityTemplate.AbilityToHitCalc);
			if (StandardAim != none && StandardAim.bReactionFire) {
				//`log("S: " $ AbilityTemplate.DataName);
				AddSRFEffects(AbilityTemplate);
			}
			else if (hasReserve) {
				//`log("R: " $ AbilityTemplate.DataName);
				AddSRFEffects(AbilityTemplate);
			}
		}
	}

	return Templates;
}

static function AddSRFEffects(X2AbilityTemplate Template)
{
	local SRF_X2Effect_SRF SuppressedEffect;
	//local X2Effect_PersistentStatChange SuppressedEffect;
	local SuppressiveReactionFireConfig srfConfig;
	local int willPenalty;
	local int aimPenalty;
	local int critPenalty;
	local int mobilityPenalty;
	local int defensePenalty;
	local X2Condition_UnitProperty excludeConditions;
	
	srfConfig = new class'SuppressiveReactionFireConfig';
	willPenalty = srfConfig.getWillPenalty();
	aimPenalty = srfConfig.getAimPenalty();
	critPenalty = srfConfig.getCritPenalty();
	mobilityPenalty = srfConfig.getMobilityPenalty();
	defensePenalty = srfConfig.getDefensePenalty();

	SuppressedEffect = new class'SRF_X2Effect_SRF';
	SuppressedEffect.BuildPersistentEffect(1, false, false, true, eGameRule_PlayerTurnEnd);
	SuppressedEffect.EffectName = 'SRF';
	SuppressedEffect.bRemoveWhenTargetDies = true;
	SuppressedEffect.bUniqueTarget = false;
	SuppressedEffect.bDupeForSameSourceOnly = false;
	SuppressedEffect.bUseSourcePlayerState = true;
	SuppressedEffect.bIsImpairingMomentarily = true;
	SuppressedEffect.bApplyOnHit = true;
	SuppressedEffect.bApplyOnMiss = true;
	SuppressedEffect.SetDisplayInfo(ePerkBuff_Penalty, "Suppressed by Reaction Fire", "Action Interrupted! Suffering " $ aimPenalty $ " penalty to aim and " $ willPenalty $ " to will and " $ critPenalty $ " to critical chance", Template.IconImage, true);
	SuppressedEffect.AddPersistentStatChange(eStat_Will, -willPenalty);
	SuppressedEffect.AddPersistentStatChange(eStat_Offense, -aimPenalty);
	SuppressedEffect.AddPersistentStatChange(eStat_CritChance, -critPenalty);

	SuppressedEffect.AddPersistentStatChange(eStat_Mobility, -mobilityPenalty);
	SuppressedEffect.AddPersistentStatChange(eStat_Defense, -defensePenalty);
	SuppressedEffect.DuplicateResponse = eDupe_Refresh;
	Template.AddTargetEffect(SuppressedEffect);

	excludeConditions = new class'X2Condition_UnitProperty';
	excludeConditions.ExcludeRobotic = srfConfig.getExcludeRobotic();
	SuppressedEffect.TargetConditions.AddItem(excludeConditions);
}
