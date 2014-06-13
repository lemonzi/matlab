function fullfigure(fig)

    if nargin < 1
        fig = gcf;
    end

    set(fig, 'units', 'normalized', 'outerposition', [0 0 1 1]);
    set(gca,'Position',[0 0 1 1]);

end