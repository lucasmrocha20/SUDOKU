math.randomseed(os.time())

sudoku = {}

function criarSudoku ()
    for i = 1, 9 do
        sudoku[i] = {}
        for j = 1, 9 do
            sudoku[i][j] = {valor = 0, constante = false}
        end
    end
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

function posicao()
    return math.random(#sudoku)
end

function adicionarValor(constante)
    continuar = false
    repeat
        linha = posicao()
        coluna = posicao()
        continuar = not(posicaoLivre())
        if(checarPosicao(linha, coluna)) then
            if(constante ~= nil) then
                sudoku[linha][coluna].constante = constante
            end
                sudoku[linha][coluna].valor = novoValor()               
            continuar = true
        end
    until continuar
end

function novoValor()
    continuar = false
    repeat
        valor = math.random(9)
        if(naoExiste(valor)) then
            return valor
        end
    until continuar
end

function naoExiste(valor)
    for i = 1, #sudoku do
        for j = 1, #sudoku do
            if(sudoku[i][j].valor == valor) then
                return false
            end
        end
    end
    return true
end


function preenchimentoInicial()
    for i = 1, 9 do
        adicionarValor(true)
    end
end

function adicionar(i,j)
    if(not(sudoku[i][j].constante)) then
        sudoku[i][j].valor = sudoku[i][j].valor + 1
        if(sudoku[i][j].valor == 10) then
            sudoku[i][j].valor = 0
        end
    end
end

function valorInvalido(lin, col)
    for i = 1, #sudoku do
        for j = 1, #sudoku do
            if(sudoku[i][j].valor == sudoku[lin][col].valor)then
                if(i == lin and col == j) then
                else
                    return true
                end
            end
        end
    end
    return false
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

function novoSudoku(tamanho)
    criarSudoku(tamanho)
    preenchimentoInicial()
end

function mostrar()
    for i = 1, #sudoku do
        for j = 1, #sudoku do
            io.write('['..sudoku[i][j].valor..']')
        end
        io.write('\n')
    end
end

return sudoku