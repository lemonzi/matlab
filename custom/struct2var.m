function struct2var(s)
% struct2var(s)
% Loads each field of the struct as a local variable named after it

  cellfun(@(n,v) assignin('caller',n,v),fieldnames(s),struct2cell(s));

end