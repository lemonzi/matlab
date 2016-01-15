function saveData(filename, data)
% saveData(filename, data)

    save(filename, '-struct', 'data');

end

