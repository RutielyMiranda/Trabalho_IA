% Trabalho de Inteligência Artificial
% Aluna: Rutiely Miranda de Sousa - 20181BB0035
%
% O Jogo é ganho ao pegar todos os ouros no mapa, e voltar para a
% posição inicial (X:1, Y:1)

% Tamanho do mapa = 5x5
% Rota para ganhar o jogo
% d. ->
% d. ->
% d. ->
%% {pegou ouro; ouro = 100 unidades} ->
% depois que pegar o ouro, voltar para a posição inicial e depois:
% d. ->
% d. ->
% s. ->
% s. ->
%% {pegou ouro; ouro = 200 unidades}
%depois voltar para posição inicial usando:
% a. ->
% a. ->
% w. ->
% w. -> {Você ganhou o jogo}

%% Rota para perder o jogo!
% d. ->
% d. ->
% d. ->
% s. ->
%% O wumpus te comeu, você perdeu o jogo

%% Rota para perder o jogo!
% s. ->
% s. ->
% s. ->
% d. ->
% d. ->
% d.
%% Você caiu no buraco, você perdeu o jogo







:- dynamic
([
    var_tamanho_mundo/1,
    var_user_ouro/1,
    var_actor_w/2,
    var_actor_o/2,
    var_actor_o_coletado/2,
    var_actor_o_maximo/1,
    var_actor_a/2,
    var_user_localizacaoX/1,
    var_user_localizacaoY/1
]).


%% inicio
iniciar :-
    %% chamando predicados de resetar
    resetar_tudo,
    iniciar_tutorial,
    iniciar_fatos.

%% limpando tudo da base de dados
resetar_tudo :-
    retractall(var_tamanho_mundo(_)),
    retractall(var_user_ouro(_)),
    retractall(var_actor_w(_,_)),
    retractall(var_actor_o(_,_)),
    retractall(var_actor_o_coletado(_,_)),
    retractall(var_actor_o_maximo(_)),
    retractall(var_actor_a(_,_)),
    retractall(var_user_localizacaoX(_)),
    retractall(var_user_localizacaoY(_)).

%% fatos
iniciar_fatos :-
    %% informações do mundo
    assert(var_tamanho_mundo(5)),
    assert(var_user_ouro(0)),

    %% localização do wumpus
    assert(var_actor_w(2,4)),

    %% localização do ouro
    assert(var_actor_o(3,3)),
    assert(var_actor_o(1,4)),

    %% localização do abismo
    assert(var_actor_a(4,4)),

    %% quantidade maxima de ouro que diz quando ganhou ->
    %% deixei 200 pq coloquei apenas dois lugares de ouro
    assert(var_actor_o_maximo(200)),

    %% localização do usuario
    registrar_nova_localizacao(1,1).

iniciar_tutorial :-
    %% tutorial escrito do que o cara pode fazer
    writeln('------------------ Mundo de Wumpus ------------------'),
    writeln('Seu objetivo é achar ouro e retornar vivo'),
    writeln('Seus movimentos são: w a s d').


%% -------------- start movimentacoes
w :-
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln('Movimentação escolhida: Cima'),
    var_user_localizacaoX(LXC),
    var_user_localizacaoY(LYC),
    NovoValor is LXC-1,
    andar(NovoValor,LYC).

a :-
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln('Movimentação escolhida: Esquerda'),
    var_user_localizacaoX(LXE),
    var_user_localizacaoY(LYE),
    NovoValor is LYE-1,
    andar(LXE,NovoValor).

d :-
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln('Movimentação escolhida: Direita'),
    var_user_localizacaoX(LXD),
    var_user_localizacaoY(LYD),
    NovoValor is LYD+1,
    andar(LXD,NovoValor).

s :-
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln('Movimentação escolhida: Baixo'),
    var_user_localizacaoX(LXB),
    var_user_localizacaoY(LYB),
    NovoValor is LXB+1,
    andar(NovoValor,LYB).

%% -------------- start movimentacoes
andar(X,Y):-

    %% verificar se pode andar na direção solicitada
    (
        %% se nao
        (not(verificar_posicao(X,Y)) -> writeln('Você não pode andar para este lado'))
        ;
        %% se sim
        (
            (verificar_posicao(X,Y)) ->
                (registrar_nova_localizacao(X,Y)),
                (
                    (
                        %% verdade que tem wumpus
                        (tem_wumpus(X,Y) -> (writeln('O WUMPUS TE ENGOLIU!'), iniciar))
                        ;
                        %% ou verdade que tem abismo
                        (tem_abismo(X,Y) -> (writeln('VOCÊ CAIU NO TARTARO DO INFERNO!!!'), iniciar))
                    )
                    ;
                    %% OU
                    (
                        %%  não tem wumpus e nem abismo
                        %% verdade de executar percepcao
                        verificar_percepcao(X,Y),
                        %% verdade de executar ouro
                        verificar_ouro(X,Y),
                        mostrar_ouro,
                        verificar_se_venceu -> (writeln('VENCEU!'), msg_continuar,iniciar)

                    )
                )
        )
    ).

verificar_posicao(X,Y) :-
    (X >= 1),
    (X =< 5),
    (Y >= 1),
    (Y =< 5).

registrar_nova_localizacao(X,Y) :-
    %% limpa localizacao antes
    retractall(var_user_localizacaoX(_)),
    retractall(var_user_localizacaoY(_)),

    %% assume nova
    assert(var_user_localizacaoX(X)),
    assert(var_user_localizacaoY(Y)),

    %%  retorna mensagem
    write('Você está em X:'), write(Y), write(' Y:'), writeln(X).

tem_wumpus(X,Y) :-
    var_actor_w(X,Y).

ntem_wumpus(X,Y) :-
    not(var_actor_w(X,Y)).

tem_abismo(X,Y) :-
    var_actor_a(X,Y).

ntem_abismo(X,Y) :-
    not(var_actor_a(X,Y)).

verificar_percepcao(X,Y):-
    ZX1 is X+1,
    ZX2 is X-1,
    ZY1 is Y+1,
    ZY2 is Y-1,
    (
        (
            (tem_wumpus(X,ZY1); tem_wumpus(X,ZY2); tem_wumpus(ZX1,Y); tem_wumpus(ZX2,Y))
            -> writeln('Você sentiu um cheiro ruim neste lugar!')
        )
        ;
        (
            % writeln('Parece não ter cheiro ruim aqui!')
            true
        )

    ),
    (
        (
            (tem_abismo(X,ZY1); tem_abismo(X,ZY2); tem_abismo(ZX1,Y); tem_abismo(ZX2,Y))
            -> writeln('Você sentiu uma brisa neste lugar!')
        )
        ;
        (
            % writeln('Parece não ter brisa aqui!')
            true
        )

    ).

verificar_ouro(X,Y):-
    (
        (
            (var_actor_o(X,Y), not(var_actor_o_coletado(X,Y)))->
            (
                writeln('ACHOU OURO!'),
                var_user_ouro(OUR),
                assert(var_actor_o_coletado(X,Y)),
                ValorOuro is OUR+100,
                retractall(var_user_ouro(_)),
                assert(var_user_ouro(ValorOuro))
            )
        )
        ;
        true
    ).

verificar_se_venceu:-
    var_user_localizacaoX(1),
    var_user_localizacaoY(1),
    var_user_ouro(OUR),
    var_actor_o_maximo(OUR2),
    OUR >= OUR2.

mostrar_ouro:-
    var_user_ouro(OUR),
    write('Você carrega: '), write(OUR), writeln(' unidades de ouro').

msg_continuar:-
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln('REINICIANDO O PRÓXIMO JOGO'),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln(''),
    writeln('').
