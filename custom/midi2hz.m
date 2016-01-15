function hz = midi2hz(midi)
% Converts a MIDI note number to Hz (A4 = 440, equal temperament)

    hz = 440 * 2 .^ ((midi-69) / 12);

end

