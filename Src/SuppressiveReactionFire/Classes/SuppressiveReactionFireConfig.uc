class SuppressiveReactionFireConfig extends Object config(SuppressiveReactionFire);

var config int WillPenalty;
var config int AimPenalty;
var config int CritPenalty;
var config int MobilityPenalty;
var config int DefensePenalty;
var config bool ExcludeRobotic;

simulated function int getWillPenalty()
{
	return WillPenalty;
}

simulated function int getAimPenalty()
{
	return AimPenalty;
}

simulated function int getCritPenalty()
{
	return CritPenalty;
}

simulated function int getMobilityPenalty()
{
	return MobilityPenalty;
}

simulated function int getDefensePenalty()
{
	return DefensePenalty;
}

simulated function bool getExcludeRobotic()
{
	return ExcludeRobotic;
}