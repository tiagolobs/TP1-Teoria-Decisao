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
%   Define o programa para a função objetivo I.
% =========================================================================

close all
clear all
clc

clientes = csvread('clientes.csv');
pontos_xy = clientes(randperm(500,100),:);

fprintf("Inicio\n");

melhor_ind = pontos_xy;
[melhor_dist,alocacao_geral] = TC_I_FO_II(pontos_xy,clientes);
melhor_demanda = sum(sum(alocacao_geral~=0))/500;
if melhor_demanda < 0.95
   melhor_dist = melhor_dist*20; 
end

geracoes = 1200;
temperatura = 15;
fprintf("Etapa 1 ...\n");
while geracoes > 0
    
    pontos_xy = TC_I_MUT(pontos_xy,temperatura);
    
    [dist,alocado] = TC_I_FO_II(pontos_xy,clientes);
    demanda = sum(sum(alocado~=0))/500;
    
    if (dist < melhor_dist && demanda >= 0.95) || (dist <= melhor_dist && demanda > melhor_demanda && demanda >= 0.95)
        melhor_ind = pontos_xy;
        melhor_dist = dist;
        melhor_demanda = demanda;
        alocacao_geral = alocado;
    end
    
    geracoes = geracoes - 1;
    temperatura = temperatura*0.9;
    if temperatura <= 0.1
        temperatura = 15;
    end
end

%% Ponto de refinamento
pontos_xy = melhor_ind;
geracoes = 120;
temperatura = 1;
fprintf("Etapa 2 ...\n");
while geracoes > 0
    
    pontos_xy = TC_I_MUT(pontos_xy,temperatura);
    
    [dist,alocado] = TC_I_FO_II(pontos_xy,clientes);
    demanda = sum(sum(alocado~=0))/500;
    
    if (dist < melhor_dist && demanda >= 0.95) || (dist <= melhor_dist && demanda > melhor_demanda && demanda >= 0.95)
        melhor_ind = pontos_xy;
        melhor_dist = dist;
        melhor_demanda = demanda;
        alocacao_geral = alocado;
    end
    
    geracoes = geracoes - 1;
    temperatura = temperatura*0.99;
    if temperatura <= 0.1
        temperatura = 1;
    end
end
fprintf("Fim\n\n");
fprintf("Menor soma das distâncias: %d\n", melhor_dist);
fprintf("Pontos utilizados: %d\n", sum(sum(alocacao_geral,2)~=0));
fprintf("Alocacao: %0.3f\n", melhor_demanda);

figure();
plot(melhor_ind(sum(alocacao_geral,2)~=0,1),melhor_ind(sum(alocacao_geral,2)~=0,2),'*r',clientes(:,1),clientes(:,2),'.b',clientes(sum(alocacao_geral,1)==0,1),clientes(sum(alocacao_geral,1)==0,2),'ok');
grid minor;