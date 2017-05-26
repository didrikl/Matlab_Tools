function [col, cancel] = Select_Extra_Channel(vars, col)
    % let the user select and add extra channels for editing
    if nargin<2, col = []; end
    cancel = false;
    N = length(vars);
    menu = [vars,{'All'}];
    for j=col, menu{j} = [menu{j},' (Cancel)']; end
    opt = Ask_List(menu,'Select channel',-1,'\t\t');
    if opt==col, cancel=true; return; end
    if opt==N+1, col=1:N; end
    if opt<=N, col = [col,opt]; end
    col = unique(col);
end