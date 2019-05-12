%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia Elétrica
% Engenharia de Sistemas
% Teoria da Decisão
%
% Autor:
%   Rafael Magalhães Nunes
%
% Atualização: 12/05/2019
%
% Nota:
%   Define as 6 estruturas de vizinhanças.
% =========================================================================

function pontos_xy = TC_I_MUT(pontos_xy,temperatura)
% 6 maneiras de andar pelo espaço de forma aleatoria
escolha = randi(6,1);
switch escolha
    case 1
        %disp(escolha);
        for i = 1:size(pontos_xy,1)
            add = random('unif',-1,1)*temperatura;
            while (pontos_xy(i,1) + add > 800 || pontos_xy(i,1) + add < 0)
                add = random('unif',-1,1)*temperatura;
            end
            pontos_xy(i,1) = pontos_xy(i,1) + add;
            
            add = random('unif',-1,1)*temperatura;
            while (pontos_xy(i,2) + add > 800 || pontos_xy(i,2) + add < 0)
                add = random('unif',-1,1)*temperatura;
            end
            pontos_xy(i,2) = pontos_xy(i,2) + add;
        end
    case 2
        %disp(escolha);
        for i = 1:size(pontos_xy,1)
            add = random('wbl',1,1)*temperatura*randi([-1 1]);
            while (pontos_xy(i,1) + add > 800 || pontos_xy(i,1) + add < 0)
                add = random('wbl',1,1)*temperatura*randi([-1 1]);
            end
            pontos_xy(i,1) = pontos_xy(i,1) + add;
            
            add = random('wbl',1,1)*temperatura*randi([-1 1]);
            while (pontos_xy(i,2) + add > 800 || pontos_xy(i,2) + add < 0)
                add = random('wbl',1,1)*temperatura*randi([-1 1]);
            end
            pontos_xy(i,2) = pontos_xy(i,2) + add;
        end
    case 3
        %disp(escolha);
        for i = 1:size(pontos_xy,1)
            add = random('exp',1,1)*temperatura*randi([-1 1]);
            while (pontos_xy(i,1) + add > 800 || pontos_xy(i,1) + add < 0)
                add = random('exp',1,1)*temperatura*randi([-1 1]);
            end
            pontos_xy(i,1) = pontos_xy(i,1) + add;
            
            add = random('exp',1,1)*temperatura*randi([-1 1]);
            while (pontos_xy(i,2) + add > 800 || pontos_xy(i,2) + add < 0)
                add = random('exp',1,1)*temperatura*randi([-1 1]);
            end
            pontos_xy(i,2) = pontos_xy(i,2) + add;
        end
    case 4
        %disp(escolha);
        for i = 1:size(pontos_xy,1)
            if rand(1) < 0.50
                add = random('norm',0,1)*temperatura;
                while (pontos_xy(i,1) + add > 800 || pontos_xy(i,1) + add < 0)
                    add = random('norm',0,1)*temperatura;
                end
                pontos_xy(i,1) = pontos_xy(i,1) + add;
                add = random('norm',0,1)*temperatura;
                while (pontos_xy(i,2) + add > 800 || pontos_xy(i,2) + add < 0)
                    add = random('norm',0,1)*temperatura;
                end
                pontos_xy(i,2) = pontos_xy(i,2) + add;
            end
        end
    case 5
        %disp(escolha);
        for i = 1:size(pontos_xy,1)
            if rand(1) < 0.50
                add = random('unif',-1,1)*temperatura;
                while (pontos_xy(i,1) + add > 800 || pontos_xy(i,1) + add < 0)
                    add = random('unif',-1,1)*temperatura;
                end
                pontos_xy(i,1) = pontos_xy(i,1) + add;
                add = random('unif',-1,1)*temperatura;
                while (pontos_xy(i,2) + add > 800 || pontos_xy(i,2) + add < 0)
                    add = random('unif',-1,1)*temperatura;
                end
                pontos_xy(i,2) = pontos_xy(i,2) + add;
            end
        end
    case 6
        %disp(escolha);
        for i = 1:size(pontos_xy,1)
            if rand(1) < 0.50
                add = random('exp',1,1)*temperatura*randi([-1 1]);
                while (pontos_xy(i,1) + add > 800 || pontos_xy(i,1) + add < 0)
                    add = random('exp',1,1)*temperatura*randi([-1 1]);
                end
                pontos_xy(i,1) = pontos_xy(i,1) + add;
                add = random('exp',1,1)*temperatura*randi([-1 1]);
                while (pontos_xy(i,2) + add > 800 || pontos_xy(i,2) + add < 0)
                    add = random('exp',1,1)*temperatura*randi([-1 1]);
                end
                pontos_xy(i,2) = pontos_xy(i,2) + add;
            end
        end
end
end

