/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_Gong_Gong_CallTest
{
    @IsTest
    private static void testTrigger()
    {
        // Force the dlrs_Gong_Gong_CallTrigger to be invoked, fails the test if org config or other Apex code prevents this.
        dlrs.RollupService.testHandler(new Gong__Gong_Call__c());
    }
}