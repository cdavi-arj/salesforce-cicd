@IsTest
public class CaseTriggerControlTest {

    @IsTest
    static void testCaseTriggerControl() {
        // Garante que a variável estática inicia como false
        System.assertEquals(false, CaseTriggerControl.isRunning);

        // Instancia a classe para disparar o construtor
        CaseTriggerControl control = new CaseTriggerControl();

        // Apenas debug, mas podemos marcar que a classe foi instanciada
        System.assertNotEquals(null, control);

        // Podemos alterar a variável estática para testar comportamento
        CaseTriggerControl.isRunning = true;
        System.assertEquals(true, CaseTriggerControl.isRunning); 
        // update
    }
}
