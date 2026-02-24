// parsePR.js
const fs = require('fs');

async function extractTests() {
    // Recebe o corpo da PR via variável de ambiente
    const body = process.env.PR_BODY || '';
    
    // Por padrão, roda todos os testes
    let tests = 'all';

    // Procura padrão Apex::[...]::Apex
    const match = body.match(/Apex::\[(.*?)\]::Apex/);
    if (match && match[1]) {
        // Extrai as classes e remove espaços desnecessários
        tests = match[1].split(',').map(c => c.trim()).join(',');
    }

    // Escreve o resultado em um arquivo
    await fs.promises.writeFile(__dirname + '/testsToRun.txt', tests);
}

extractTests();
