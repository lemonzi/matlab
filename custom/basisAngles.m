function [pitch, yaw, roll] = basisAngles(basis, units)
% basisAngles(basis, units)
% Gets pitch, yaw and roll from the given rotation matrix
% In radians unless units is 'degrees'

    yaw = asin(basis(1,3));
    C   = cos(yaw);

    if abs(C) > 0.005
        % No gimball lock
        tx =  basis(3,3) / C;
        ty = -basis(2,3) / C;
        pitch = atan2(ty, tx);
        tx =  basis(1,1) / C;
        ty = -basis(1,2) / C;
        roll = atan2(ty, tx);
    else
        % Gimball lock
        pitch = 0;
        tx = basis(2,2);
        ty = basis(2,1);
        roll = atan2(ty, tx);
    end

    if pitch < -pi/2
        pitch = pitch + 2*pi;
    end
    if yaw < -pi/2
        yaw = yaw + 2*pi;
    end
    if roll < -pi/2
        roll = roll + 2*pi;
    end

    if nargin > 1 && strcmp(units, 'degrees')
        pitch = pitch * 180 / pi;
        yaw   = yaw   * 180 / pi;
        roll  = roll  * 180 / pi;
    end

end

