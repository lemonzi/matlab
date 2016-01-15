function midi = hz2midi(hz)
% Converts a frequency on Hz to MIDI note number (A4 = 440, equal temperament)
% If the frequency is not exact, the note is NOT rounded
% I think the decimal part can be converted to cents if multiplied by 100

    midi = 69 + 12 * log(hz/440) / log(2);

end

