% Racha Cuca - Trabalho de Inteligência Artificial
%
% Teste de QI de Einstein
%
% Aluna: Rutiely Miranda de Sousa - 20181BCC0035
%
% Regras básicas para resolver o teste:
% 1 - Há 5 casas de diferentes cores;
% 2 - Em cada casa mora uma pessoa de uma diferente nacionalidade;
% 3 - Esses 5 proprietários bebem diferentes bebidas, fumam diferentes
% tipos de cigarros e possuem um certo animal de estimação;
% 4 - Nenhum deles tem o mesmo animal, fumam o mesmo cigarro ou bebem a
% mesma bebida.
%
% Dicas:
% 01) O Norueguês vive na primeira casa.
% 02) O Inglês vive na casa Vermelha.
% 03) O Sueco tem Cachorros como animais de estimação.
% 04) O Dinamarquês bebe Chá.
% 05) A casa Verde fica do lado esquerdo da casa Branca.
% 06) O homem que vive na casa Verde bebe Café.
% 07) O homem que fuma Pall Mall cria Pássaros.
% 08) O homem que vive na casa Amarela fuma Dunhill.
% 09) O homem que vive na casa do meio bebe Leite.
% 10) O homem que fuma Blends vive ao lado do que tem Gatos.
% 11) O homem que cria Cavalos vive ao lado do que fuma Dunhill.
% 12) O homem que fuma BlueMaster bebe Cerveja.
% 13) O Alemão fuma Prince.
% 14) O Norueguês vive ao lado da casa Azul.
% 15) O homem que fuma Blends é vizinho do que bebe Água.
%
% Para rodar digite: resolve.

left(X, Y, [X | [Y | _]]).
left(X, Y, [_ | List]) :- left(X, Y, List).

neighbour(X, Y, List) :- left(X, Y, List); left(Y, X, List).

% casa(Nacionalidade, Cor, Animal, Bebida, Cigarro)
resolve :- Casas = [_, _, _, _, _],
  % 01) O Norueguês vive na primeira casa.
  Casas = [casa(noruegues, _, _, _, _), _, _, _, _],
  % 02) O Inglês vive na casa Vermelha.
  member(casa(ingles, vermelha, _, _, _), Casas),
  % 03) O Sueco tem Cachorros como animais de estimação.
  member(casa(sueco, _, cachorros, _, _), Casas),
  % 04) O Dinamarquês bebe Chá.
  member(casa(dinamarques, _, _, cha, _), Casas),
  % 05) A casa Verde fica do lado esquerdo da casa Branca.
  left(casa(_, verde, _, _, _), casa(_, branca, _, _, _), Casas),
  % 06) O homem que vive na casa Verde bebe Café.
  member(casa(_, verde, _, cafe, _), Casas),
  % 07) O homem que fuma Pall Mall cria Pássaros.
  member(casa(_, _, passaros, _, pallmall), Casas),
  % 08) O homem que vive na casa Amarela fuma Dunhill.
  member(casa(_, amarela, _, _, dunhill), Casas),
  % 09) O homem que vive na casa do meio bebe Leite.
  Casas = [_, _, casa(_, _, _, leite, _), _, _],
  % 10) O homem que fuma Blends vive ao lado do que tem Gatos.
  neighbour(casa(_, _, _, _, blends), casa(_, _, gatos, _, _), Casas),
  % 11) O homem que cria Cavalos vive ao lado do que fuma Dunhill.
  neighbour(casa(_, _, cavalos, _, _), casa(_, _, _, _, dunhill), Casas),
  % 12) O homem que fuma BlueMaster bebe Cerveja.
  member(casa(_, _, _, cerveja, bluemaster), Casas),
  % 13) O Alemão fuma Prince.
  member(casa(alemao, _, peixes, _, prince), Casas),
  % 14) O Norueguês vive ao lado da casa Azul.
  neighbour(casa(noruegues, _, _, _, _), casa(_, azul, _, _, _), Casas),
  % 15) O homem que fuma Blends é vizinho do que bebe Água.
  neighbour(casa(_, _, _, _, blends), casa(_, _, _, agua, _), Casas),

  Casas = [C1, C2, C3, C4, C5],
  C1 = casa(C1_Nacionalidade, C1_Cor, C1_Animal, C1_Bebida, C1_Cigarro),
  C2 = casa(C2_Nacionalidade, C2_Cor, C2_Animal, C2_Bebida, C2_Cigarro),
  C3 = casa(C3_Nacionalidade, C3_Cor, C3_Animal, C3_Bebida, C3_Cigarro),
  C4 = casa(C4_Nacionalidade, C4_Cor, C4_Animal, C4_Bebida, C4_Cigarro),
  C5 = casa(C5_Nacionalidade, C5_Cor, C5_Animal, C5_Bebida, C5_Cigarro), nl,

  print('1ª Casa:'), nl,
  print('--------> Cor:'), print(C1_Cor), nl,
  print('--------> Nacionalidade:'), print(C1_Nacionalidade), nl,
  print('--------> Bebida:'), print(C1_Bebida), nl,
  print('--------> Cigarro:'), print(C1_Cigarro), nl,
  print('--------> Animal:'), print(C1_Animal), nl, nl,

  print('2ª Casa:'), nl,
  print('--------> Cor:'), print(C2_Cor), nl,
  print('--------> Nacionalidade:'), print(C2_Nacionalidade), nl,
  print('--------> Bebida:'), print(C2_Bebida), nl,
  print('--------> Cigarro:'), print(C2_Cigarro), nl,
  print('--------> Animal:'), print(C2_Animal), nl, nl,

  print('3ª Casa:'), nl,
  print('--------> Cor:'), print(C3_Cor), nl,
  print('--------> Nacionalidade:'), print(C3_Nacionalidade), nl,
  print('--------> Bebida:'), print(C3_Bebida), nl,
  print('--------> Cigarro:'), print(C3_Cigarro), nl,
  print('--------> Animal:'), print(C3_Animal), nl, nl,

  print('4ª Casa:'), nl,
  print('--------> Cor:'), print(C4_Cor), nl,
  print('--------> Nacionalidade:'), print(C4_Nacionalidade), nl,
  print('--------> Bebida:'), print(C4_Bebida), nl,
  print('--------> Cigarro:'), print(C4_Cigarro), nl,
  print('--------> Animal:'), print(C4_Animal), nl, nl,

  print('5ª Casa:'), nl,
  print('--------> Cor:'), print(C5_Cor), nl,
  print('--------> Nacionalidade:'), print(C5_Nacionalidade), nl,
  print('--------> Bebida:'), print(C5_Bebida), nl,
  print('--------> Cigarro:'), print(C5_Cigarro), nl,
  print('--------> Animal:'), print(C5_Animal), nl, nl,

  print('Parabênsss!!!'), nl.
