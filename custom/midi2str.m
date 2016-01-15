function [code, octave, pClass] = midi2str(midi)
% Converts a given MIDI note to its textual representation
% It also returns octave and pitch class (0 is C)

    octave = floor(midi / 12) - 1;
    pClass = mod(midi, 12) + 1;

    noteLookup = {...
        'C','C#','D','Eb','E','F','F#','G','G#','A','Bb','B' ...
    };

    code = [noteLookup{pClass} num2str(octave)];

end

