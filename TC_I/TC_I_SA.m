%==========================================================================
% Universidade Federal de Minas Gerais
% Escola de Engenharia da UFMG
% Depto. de Engenharia Elétrica
%
% Autor:
%   Lucas S. Batista
%
% Atualização: 27/09/2018
%
% Nota:
%   Aproxima o ponto de ótimo (minimização) de um problema irrestrito
%   usando o Algoritmo Simulated Annealing (VERSÃO SIMPLES).
% =========================================================================


function [xbest, jxbest, nfe] = TC_I_SA (fobj, x, xlimites)

%
% Sintaxe
% [xbest, jxbest, nfe] = SAreal(fun, x, xlimites)
% fun     : função objetivo
% x       : vetor solução inicial [x1 x2 ... xn]
% xlimites: limites inferior e superior das variáveis 
%           [x1min x1max x2min x2max ... xnmin xnmax]
%
% Exemplo
% [xbest, jxbest, nfe] = SAreal(@fbazaraa, [+3.0 +3.0], [0 4 0 4])
% [xbest, jxbest, nfe] = SAreal(@frosenbrock, [-1.0 +1.5], [-1.5 1.5 -1.0 1.5])
% [xbest, jxbest, nfe] = SAreal(@frastrigin, [+2 +2], [-2 2 -2 2])
%

% Contador de estágios do método
k = 0;

% Contador do número de avaliações de f(.)
nfe = 0; 

% Número de variáveis de decisão
n = length(x);

% Definição dos vetores limites
lb = xlimites(1:2:end); lb = lb(:);
ub = xlimites(2:2:end); ub = ub(:);

% Desvio padrão inicial da vizinhança
sigma = 0.25;

% Temperatura inicial
[to,x,jx,nfe] = initialT(fobj,x(:).',ub,lb,sigma,xlimites,nfe,n);
t = to;

% Armazena melhor solução encontrada
xbest  = x;
jxbest = jx;

% Critério de parada do algoritmo
numEstagiosEstagnados = 0;

% Armazena o caminho percorrido em direção ao ótimo
caminho(1,:) = [xbest' jxbest];

% Imprime o resultado da busca encontrado até a iteração corrente
output(fobj, caminho, size(caminho,1), xlimites); 


% Processo iterativo
while (numEstagiosEstagnados <= 10 && nfe < 1000)        
    % Critérios para mudança de temperatura
    numAceites = 0;
    numTentativas = 0;
       
    % Fitness da solução submetida ao estágio k
    fevalin = jxbest;

    while (numAceites < 12*n && numTentativas < 100*n)
        
        % Gera uma solução na vizinhança de x
        y = uniforme_mutation(x,ub,lb,sigma,xlimites,n);
        %y = polynomial_mutation(x,ub,lb,xlimites,n);
        
        jy  = feval(fobj, y);
        nfe = nfe + 1;
        
        % Atualiza solução
        DeltaE = jy - jx;
        if (DeltaE <= 0 || rand <= exp(-DeltaE/t))
            x  = y;
            jx = jy;
            numAceites = numAceites + 1;
            
            % Atualiza melhor solução encontrada
            if (jx < jxbest)
                xbest  = x;
                jxbest = jx;  
            end        
        end
        numTentativas = numTentativas + 1; 
        
        % Armazena o caminho percorrido em direção ao ótimo
        caminho(size(caminho,1)+1,:) = [x' jx];
    
        % Atualiza o percusso em direção ao ótimo
        output(fobj, caminho, size(caminho,1), xlimites);
    end
    
    % Atualiza o desvio padrão da vizinhança  
    A = numAceites/numTentativas;
    if (A > 0.20)
        sigma = 1*sigma;
    elseif (A < 0.05)
        sigma = 1*sigma;
    end
    
    % Atualiza a temperatura
    t = 0.9*t;
    
    % Avalia critério de estagnação
    if (jxbest < fevalin)
        numEstagiosEstagnados = 0;
    else
        numEstagiosEstagnados = numEstagiosEstagnados + 1;        
    end
    
    % Avalia critério de reinicialização da temperatura
    if (t < 1e-1)
        t = to;
    end
        
    % Atualiza contador de estágios de temperatura
    k = k + 1;   
end
fprintf('\n')

figure
plot(0:size(caminho,1)-1,caminho(:,end),'k-','linewidth',2)
xlabel('Número de iterações')
ylabel('Valor da função objetivo')

