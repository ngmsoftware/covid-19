function state = customPlotfun(options,state,flag, s, index, dt)

    [~, bestIndividualIdx] = min(state.Score);
    p1 = state.Population(bestIndividualIdx,:);
    
    plotResult(s,index,dt,p1);
end

