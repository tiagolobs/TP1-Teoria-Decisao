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
%   Define o ponto mais próximo disponível.
% =========================================================================

function f = menorDist(y,distancia,alocado)
% Retorna o ponto mais próximo disponível
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