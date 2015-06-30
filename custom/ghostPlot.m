function h = ghostPlot(h,x,y)

    persistent xbuffer;
    persistent ybuffer;
    
    if strcmp(h,'clear')
        xbuffer = [];
        ybuffer = [];
        return;
    end
    
    if (nargin < 3)
        y = x;
        x = h;
        h = gcf;
    end     
    
    if (size(xbuffer, 3) > 20)
        xbuffer = xbuffer(:,:,2:end);
        ybuffer = ybuffer(:,:,2:end);
    end
    
    xbuffer = cat(3, xbuffer, x);
    ybuffer = cat(3, ybuffer, y);
    
    figure(h);
    
    nn = size(xbuffer, 3);
    for i = 1:nn
        shade = log(nn-i+1)/(log(nn)+eps);
        plot(xbuffer(:,:,i), ybuffer(:,:,i), 'Color', [1,1,1] * shade);
        hold on
    end
    
    plot(x, y, 'k.-');
    hold off
    
end