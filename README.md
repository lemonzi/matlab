MATLAB Tools
------------

This repository contains various useful functions and toolboxes that I've put together for convenience.

Do NOT add it with subfolders, especially if you cloned the repo, because the `.git` folder will be added as well, and you will miss some fancy platform-dependent path injection things. Run the `startup` function provided with the toolbox instead.

If you set the folder with the toolbox as your default matlab folder, it will be run automatically. If not, create a script named `startup.m` in you default matlab folder and run it from there. In that case, you don't even need to add the toolbox to your path; just call `run('<path to the toolbox>/startup.m')` and you're good to go.

Or you can just go old-school and add them manually, of course.

So far, the functions in the root folder are made by @lemonzi, and the folders contain various contributions from MathExchange and other places. License files have been kept when possible.

The toolboxes should not be expected to be the same as in the submission; over time, I plan to clean them up where appropriate and maybe change their interfaces. In some cases, I think it would be better to have packages instead of a bunch of functions with a prefix.

