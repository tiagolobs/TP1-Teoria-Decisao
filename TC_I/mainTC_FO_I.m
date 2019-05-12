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
[melhor_aloc,alocacao_geral] = TC_I_FO_I(pontos_xy,clientes);
melhor_demanda = sum(sum(alocacao_geral~=0))/500;
if melhor_demanda < 0.95
    melhor_aloc = melhor_aloc*2;
end

geracoes = 1200*2;
temperatura = 15;

fprintf("Etapa 1 ...\n");
while geracoes > 0
    pontos_xy = TC_I_MUT(pontos_xy,temperatura);
    
    [n_aloc,alocado] = TC_I_FO_I(pontos_xy,clientes);
    demanda = sum(sum(alocado~=0))/500;
    
    if (n_aloc < melhor_aloc && demanda >= 0.95) || (n_aloc <= melhor_aloc && demanda > melhor_demanda && demanda >= 0.95)
        melhor_ind = pontos_xy;
        melhor_aloc = n_aloc;
        melhor_demanda = demanda;
        alocacao_geral = alocado;
    end
    
    geracoes = geracoes - 1;
    temperatura = temperatura*0.99;
    if temperatura <= 0.1
        temperatura = 15;
    end
end
%% Ponto para refinar o resultado encontrado
pontos_xy = melhor_ind;

geracoes = 120*2;
temperatura = 1;
fprintf("Etapa 2 ...\n");
while geracoes > 0
    pontos_xy = TC_I_MUT(pontos_xy,temperatura);
    
    [n_aloc,alocado] = TC_I_FO_I(pontos_xy,clientes);
    demanda = sum(sum(alocado~=0))/500;
    
    if (n_aloc < melhor_aloc && demanda >= 0.95) || (n_aloc <= melhor_aloc && demanda > melhor_demanda && demanda >= 0.95)
        melhor_ind = pontos_xy;
        melhor_aloc = n_aloc;
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
fprintf("Numero minimo de pontos: %i\n", melhor_aloc);
fprintf("Alocacao: %0.3f\n", melhor_demanda);
figure();
plot(melhor_ind(sum(alocacao_geral,2)~=0,1),melhor_ind(sum(alocacao_geral,2)~=0,2),'*r',clientes(:,1),clientes(:,2),'.b',clientes(sum(alocacao_geral,1)==0,1),clientes(sum(alocacao_geral,1)==0,2),'ok');
grid on