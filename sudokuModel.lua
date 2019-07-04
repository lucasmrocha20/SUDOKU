math.randomseed(os.time())

sudoku = {}

function criarSudoku (tamanho)
    for i = 1, tamanho do
        sudoku[i] = {}
        for j = 1, tamanho do
            sudoku[i][j] = {valor = 0, constante = false}
        end
    end
end

function novoSudoku()
    criarSudoku(9)
    preenchimentoInicial(25)
end

function preenchimentoInicial(quantidade)
    for i = 1, quantidade do
        adicionarValor(true)
    end
end

function adicionarValor(constante)
    continuar = false
    repeat
        linha = math.random(#sudoku)
        coluna = math.random(#sudoku)
        continuar = not(posicaoLivre())
        if(checarPosicao(linha, coluna)) then
            if(constante ~= nil) then
                sudoku[linha][coluna].constante = constante
            end
                sudoku[linha][coluna].valor = novoValor(linha, coluna)               
            continuar = true
        end
    until continuar
end

function posicaoLivre()
    for i = 1, #sudoku do
        for j = 1, #sudoku do
            if(sudoku[i][j].valor == 0) then
                return true
            end
        end
    end
    return false
end

function checarPosicao(i, j) 
    if(i >= 1 and i <= #sudoku and j >= 1 and j <= #sudoku) then 
        if(sudoku[i][j].valor ~= 0) then
            return false
        else
            return true
        end
    end
end

function novoValor(i, j)
    continuar = false
    repeat
        valor = math.random(9)
        if(valorValido(i, j, valor)) then
            return valor
        end
    until continuar
end

function valorValido(i, j, valor)
    if(linhaValida(i, valor) and colunaValida(j, valor)) then
        return true
    end
    return false
end

function linhaValida (i, valor)
    for j = 1, #sudoku do
        if(sudoku[i][j].valor == valor) then
            return false
        end
    end
    return true
end

function colunaValida (j, valor)
    for i = 1, #sudoku do
        if(sudoku[i][j].valor == valor) then
            return false
        end
    end
    return true
end

function verificar()
    for i = 1, #sudoku do
        for j = 1, #sudoku do
            if(valorInvalido(i,j)) then
                return false
            end
        end
    end
    return  true
end

function valorInvalido(lin, col)
    for i = 1, #sudoku do
        if(sudoku[i][col].valor == sudoku[lin][col].valor) then
            if(i == lin) then
            else
                return true
            end
        end
    end
    for j = 1, #sudoku do
        if(sudoku[lin][j].valor == sudoku[lin][col].valor) then
            if(j == col) then
            else
                return true
            end
        end
    end
    return false
end

function adicionar(i,j)
    if(not(sudoku[i][j].constante)) then
        sudoku[i][j].valor = sudoku[i][j].valor + 1
        if(sudoku[i][j].valor == 10) then
            sudoku[i][j].valor = 0
        end
    end
end

function mostrar()
    for i = 1, #sudoku do
        for j = 1, #sudoku do
            io.write(sudoku[i][j].valor == 0 and '[ ]' or '['..sudoku[i][j].valor..']')
        end
        io.write('\n')
    end
end

return sudoku