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
%   Define a função objetivo II.
% =========================================================================

function [f,alocado_distancia] = TC_I_FO_II(pontos_xy,clientes)
% Função objetivo
distancia = zeros(size(pontos_xy,1),size(clientes,1)); %linha ponto e colunas cliente, valor é a distância entre eles
alocado_demanda = zeros(size(pontos_xy,1),size(clientes,1)); %para qual está alocado
alocado_distancia = zeros(size(pontos_xy,1),size(clientes,1)); %para qual está alocado
for i = 1:size(pontos_xy,1)
    for j= 1:size(clientes,1)
        distancia(i,j) = sqrt((pontos_xy(i,1) - clientes(j,1))^2 + (pontos_xy(i,2) - clientes(j,2))^2);
    end
end

for j = 1:size(clientes,1)
    i = menorDist(j,distancia,alocado_demanda);
    if i ~= 0
        if distancia(i,j) <= 85
            alocado_demanda(i,j) = clientes(j,3);
        end
    end
end
for i = 1:size(pontos_xy,1)
    for j = 1:size(clientes,1)
        if alocado_demanda(i,j) ~= 0
            alocado_distancia(i,j) = distancia(i,j);
        end
    end
end
f = sum(sum(alocado_distancia));
