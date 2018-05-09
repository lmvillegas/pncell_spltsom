@ECHO OFF
SET SLOT=%1
SET VALUE=%2
%MCELL_HOME%\bin\msetmsg -n %cell_name% -u %event_handle% -S %SLOT%=%VALUE% && echo Slot %SLOT% set to %VALUE%

