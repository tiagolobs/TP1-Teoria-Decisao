%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia El�trica
% Engenharia de Sistemas
% Teoria da Decis�o
%
% Autor:
%   Rafael Magalh�es Nunes
%
% Atualiza��o: 12/05/2019
%
% Nota:
%   Define o ponto mais pr�ximo dispon�vel.
% =========================================================================

function f = menorDist(y,distancia,alocado)
% Retorna o ponto mais pr�ximo dispon�vel
menor = 800;
menor_i = 0;
for i = 1:size(distancia,1)
    d = distancia(i,y);
    if sum(alocado(i,:))+d <= 150
        if d < menor
            menor = d;
            menor_i = i;
        end
    end
end
f = menor_i;