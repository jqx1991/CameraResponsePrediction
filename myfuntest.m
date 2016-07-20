function [history,CSS_optimum,fval,exitflag,output,lambda] = myfuntest(costfun,CSS_opt0,lb,ub,maxEvals)
history.x = [];
history.fval = [];
options = optimoptions(@fmincon ,'OutputFcn',@outfun,'MaxFunEvals',maxEvals);
[CSS_optimum,fval,exitflag,output,lambda] = fmincon(costfun,CSS_opt0,[],[],[],[],lb,ub,[],options);
    function stop = outfun(x,optimValues,state)
    stop = false;
       switch state
           case 'init'
               hold on
           case 'iter'
               % Concatenate current point and objective function
               % value with history. x must be a row vector.
               history.fval = [history.fval; optimValues.fval];
               history.x = [history.x; x];
               % Concatenate current search direction with 
               % searchdir.
           case 'done'
               hold off
           otherwise
       end
    end
end