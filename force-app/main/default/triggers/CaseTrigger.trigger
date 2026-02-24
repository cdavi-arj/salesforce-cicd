trigger CaseTrigger on Case (
    before insert,
    before update,
    after insert,
    after update
) {

    // ----------------------------------------
    // Anti-recursão
    // ----------------------------------------
    if (CaseTriggerControl.isRunning) return;

    CaseTriggerControl.isRunning = true;

    try {
        /* =====================================
           BEFORE INSERT
        ===================================== */
        if (Trigger.isBefore && Trigger.isInsert) {

            CaseTriggerHandler.handleBeforeInsert(
                Trigger.new
            );
        }
        /* =====================================
           BEFORE UPDATE
           ROUTING CAPACITY
        ===================================== */
        if (Trigger.isBefore && Trigger.isUpdate) {

            CaseTriggerHandler.handleBeforeUpdate(
                Trigger.new,
                Trigger.oldMap
            );
        }
        /* =====================================
           AFTER INSERT
           EMAIL + SLA
        ===================================== */
        if (Trigger.isAfter && Trigger.isInsert) {

            CaseTriggerHandler.handleAfterInsert(
                Trigger.new
            );

            CaseTriggerHandler.assignEntitlementAfterInsert(
                Trigger.new
            );
        }
        /* =====================================
           AFTER UPDATE
           APROVAÇÃO + AGENDA
        ===================================== */
        if (Trigger.isAfter && Trigger.isUpdate) {
            // inicia aprovação automaticamente
            CaseTriggerHandler.submitForApprovalAfterStatusChange(
                Trigger.new,
                Trigger.oldMap
            );
            // cria agenda do analista
            CaseTriggerHandler.handleAfterUpdate(
                Trigger.new,
                Trigger.oldMap
            );
        }

    } finally {

        CaseTriggerControl.isRunning = false;
    }
}