function y = Delay_Shift(y,D)
	
	if D>0
        y = [y(D+1:end);nan(D,1)];
    elseif D<0
        D = -D;
        y = [nan(D,1);y(1:end-D)];
    end