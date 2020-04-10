finalizar = false
Jogador = 1
marcador = ""
game = {
  {" "," "," "},
  {" "," "," "},
  {" "," "," "}
}

-- jogador automatico
function maquinaJoga()
  local livres = {}
  local n = 1
  for i=1,3 do
    for j=1,3 do
      -- verifica as posições livres
      if game[i][j] == " "
      then
        table.insert(livres,n)
      end
      n = n + 1
    end
  end
  -- retorna um posição aleatoria livre
  return livres[math.random(1,table.getn(livres))]
end

-- checa quem ganhou
function checarGanhador(marcador)
  
  -- x x x
  -- x x x
  -- x x x
  for i=1,3 do
      if game[i][1] == marcador and  game[i][2] == marcador and game[i][3] == marcador
      then
        return true
      end
  end
  -- x _ _
  -- x _ _
  -- x _ _
  if game[1][1] == marcador and game[2][1] == marcador and game[3][1] == marcador
  then
    return true
  -- _ x _
  -- _ x _
  -- _ x _
  elseif game[1][2] == marcador and game[2][2] == marcador and game[3][2] == marcador
  then
    return true
  -- _ _ x
  -- _ _ x
  -- _ _ x
  elseif game[1][3] == marcador and game[2][3] == marcador and game[3][3] == marcador
  then
    return true
  -- _ _ x
  -- _ x _
  -- x _ _
  elseif game[1][3] == marcador and game[2][2] == marcador and game[3][1] == marcador
  then
    return true
  -- x _ _
  -- _ x _
  -- _ _ x
  elseif game[1][1] == marcador and game[2][2] == marcador and game[3][3] == marcador
  then
    return true
  end
  return false
end

-- verica se a posição ja foi ocupada
function posicaoValida(p)
  if p == " "
  then
    return true
  else
    print("Tente outra Posição")
    return false
  end
end

-- solicita uma posição para o jogador
function proximoJogador()
  if checarGanhador(marcador)
  then
    print("Jogador "..Jogador.." Ganhou")
    finalizar = true
  end
  
  if Jogador == 1
  then
    Jogador = 2
  else
    Jogador = 1
  end
end

-- preenche uma posição definida pelo jogador
function mover(posicao,marcador)
    local next = false
    if posicao <= 3
      then
        if posicaoValida(game[1][posicao])
        then
          game[1][posicao] = marcador
          next = true
        end
      elseif posicao > 3 and posicao <= 6
      then 
        if posicao == 4
        then
          posicao = 1
        elseif posicao == 5
        then
          posicao = 2
        elseif posicao == 6
        then
          posicao = 3
        end
        if posicaoValida(game[2][posicao])
        then
          game[2][posicao] = marcador
          next = true
        end
      elseif posicao > 6 and posicao <= 9
      then
        if posicao == 7
        then
          posicao = 1
        elseif posicao == 8
        then
          posicao = 2
        elseif posicao == 9
        then
          posicao = 3
        end
        if posicaoValida(game[3][posicao])
        then
          game[3][posicao] = marcador
          next = true
        end
      end
  if next
  then
    proximoJogador()
  end
  printGame()
end

-- mostra como esta o jogo antes do jogador escolher um numero
function printGame()
  local desenho = ""
  for i=1,3 do
      desenho = desenho .. game[i][1].."|"..game[i][2].."|"..game[i][3].."\n"
      desenho = desenho .. "- - -\n"
  end
  print(desenho)
end


function jogarAgora()
  local posicao = nil
  while posicao == nil do
    if Jogador == 2
    then
      posicao =  maquinaJoga()
      print(posicao)
      io.write("Jogador "..Jogador.."\n posição: "..posicao.."\n")
    else
      io.write("Jogador "..Jogador.."\nDigite a posição: ")
      posicao = io.read()
      posicao = posicao:match"%d+"
    end
  end
  posicao = tonumber(posicao)
  if Jogador == 1
  then
    marcador = "X"
  else
    marcador = "O"
  end
  mover(posicao,marcador)
end

local function main( ... )
    print("As posições são de 1 a 9")
    print("1|2|3")
    print("- - -")
    print("4|5|6")
    print("- - -")
    print("7|8|9")
    print("Bom Jogo\n\n")
    printGame()
    while finalizar ~= true do
      jogarAgora()
    end
end

main()
