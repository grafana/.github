trigger DB_Custom_Opportunity on Opportunity ( before delete, after insert, after update, after undelete )
{
	try
	{
		if ( Test.isRunningTest() && CRMfusionDBR101.DB_Globals.generateCustomTriggerException )
		{
			throw new CRMfusionDBR101.DB_Globals.TestException( 'Test exception.');
		}
		else if ( trigger.isAfter && ( trigger.isInsert || trigger.isUpdate || trigger.isUndelete ) )
		{
			CRMfusionDBR101.DB_TriggerHandler.processAfterInsertUpdateUndelete( trigger.New, trigger.Old, trigger.isInsert,
				trigger.isUpdate, trigger.isUndelete );
		}
		else if ( trigger.isBefore && trigger.isDelete )
		{
			CRMfusionDBR101.DB_TriggerHandler.processBeforeDelete( trigger.Old );
		}
	}
	catch ( Exception ex )
	{
		CRMfusionDBR101.DB_TriggerHandler.handleTriggerException( ex, 'DB_Custom_Opportunity' );
	}
}