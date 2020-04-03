function p0 = gridsearch(lb, ub, NGrid, N, Sz, idxS, dt)

    %parameters = [beta, 0.0, gamma, 0.0, 0.0, 0.0, N, N0, time1, beta2 gamma2 zeroPad];

    p = lb;
    
    minErr = inf;
    
    for i1=0:NGrid-1
        for i2=0:NGrid-1
                for i4=0:NGrid-1
                    for i5=0:NGrid-1
                        for i6=0:NGrid-1
                            p = lb + (ub-lb).*[i1 0 i2 0 0 0 N 1 i4 i5 i6 0]/NGrid;
                            err = modelError(p, Sz,idxS);
                            if (err<minErr)
                                disp(err);
                                p0 = p;
                                minErr = err;
                                plotResult(Sz,idxS,dt,p0);
                                drawnow();
                            end
                            
                        end
                    end
                end
        end
        disp(sprintf('i1 = %d\n',i1));
    end


end