colors = {
    white = {0.78, 0.97, 0.97},
    turquesa = {0, 0.80, 0.81, 0.6},
    cyan = {0, 0.54, 0.54},
    gray = {237/255, 235/255, 233/255}
}
--variaveis
tableChanged = false

local background = display.newRect(display.contentCenterX, display.contentCenterY, 800, 800)
background.fill = colors.gray

tableGroup = display.newGroup()
tableGroup.x, tableGroup.y = -3, 30

tableRect = display.newRoundedRect(tableGroup, 130, 270, 400, 400, 5)
tableRect.fill = colors.turquesa

showMsg = display.newText('', 165, 80, "sudokuFont", 20)
showMsg:setFillColor(26/255, 188/255, 156/255)

function avaliate( event )
    avaliated = false
    if(tableChanged) then
        if(posicaoLivre()) then
            msg = 'preencha todos os campos'
        else
            avaliated = verificar()
            msg = avaliated and 'sudoku concluído parabéns' or 'Existem valores duplicados'
        end
        showMsg.text = msg
        showSudoku(sudoku, avaliated)
    end
end

function newText(group, x, y, text, value)
    rect = display.newRoundedRect(group, x, y, 100, 50, 5)
    rect.fill = colors.white
    rect.value = display.newText(value, x + group.x, y + group.y, "sudokuFont", 22)
    rect.value:setFillColor(26/255, 188/255, 156/255)
    if(text ~= nil) then
        placarText = display.newText(text, x + group.x, group.y - 72, "sudokuFont", 30)
        placarText:setFillColor(26/255, 188/255, 156/255)
    else
        rect:addEventListener("touch", avaliate)
    end
end

tabela = display.newText("SUD    KU", 157, -10, "sudokuFont", 50)
tabela:setFillColor(26/255, 188/255, 156/255)

local function rotateEfect()
    if ( reverse == 0 ) then
        reverse = 1
        transition.to( newButton, { rotation=360, time=900, transition=easing.inOutCubic } )
    else
        reverse = 0
        transition.to( newButton, { rotation=-360, time=900, transition=easing.inOutCubic } )
    end
end

---new game
function newGame( event )
    showMsg.text = ''
    novoSudoku(3)
    showSudoku(sudoku)
    rotateEfect()
    tableChanged = false
end
--new game button
newX, newY = 175, -10
newButton = display.newImage("refresh.png", newX, newY)
newButton.rotation = -45
local reverse = 1

newButton:addEventListener("tap", newGame)

-----------------------click--------------
local function clickEvent( event )
    if(not(tableChanged)) then
        tableChanged = true
    end
    i, j = event.target.i, event.target.j
    adicionar(i,j)
    showSudoku(sudoku)
end

function newRect(group, i, j, x, y, width, height, color)
    local rect = nil
        rect = display.newRoundedRect(group, x, y, width, height,5)
        rect.fill, rect.i, rect.j = color, i, j
        rect.value = display.newText("", x + tableGroup.x, y + tableGroup.y, "sudokuFont", 30)
        rect:addEventListener("tap", clickEvent)
        rect.value:setFillColor(0, 0.54, 0.54)
    return rect
end
-----------------------click--------------

function tableView()
    posX, posY, pecaSize = -12, 100, 33
    for i = 1, 9 do
        value = 0
        for j = 1, 9 do
            rect = newRect(tableGroup, i, j, posX + 35 * j, posY, pecaSize, pecaSize, colors.white)
        end
        posY = posY + pecaSize + 9
    end
end
tableView()

function showSudoku(sudoku, avaliated)
    local k = 2
    for i = 1, #sudoku do
        for j = 1, #sudoku do
            if (sudoku[i][j].valor == 0) then
                tableGroup[k].fill = colors.white
                tableGroup[k].value:setFillColor(0, 0.54, 0.54)
                tableGroup[k].value.text = ""
            else
                tableGroup[k].value.text = sudoku[i][j].valor
                tableGroup[k].fill = colors.white
                tableGroup[k].value:setFillColor(0, 0.54, 0.54)
                if(valorInvalido(i, j) and avaliated == false) then
                    tableGroup[k].value:setFillColor(242/255, 9/255, 9/255)
                end
            end
            k = k + 1
        end
    end
end

newText(tableGroup, 160, 500, nil, "avaliar")