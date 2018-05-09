@echo off
REM $1 is action id 
REM $2 is ACL
REM $3 is ECF
REM $4 is IAS name
REM $5 is cellname
REM
REM $6 is Action Group
REM $7 is Action Label
REM $8 is Lookup in CR (true/false)

REM Step 1 get the file
set TEMP_MRL_FILE_DIR="%MCELL_HOME%\etc\%5%\kb\bin"
set TEMP_MRL_FILE="%MCELL_HOME%\etc\%5%\kb\bin\basicsolution_actions.mrl"
if not exist %TEMP_MRL_FILE% (
echo File %TEMP_MRL_FILE% not found.
goto END
)

REM Step 2 append the file with new action
set ACL1=%2%
set ACL3=%ACL1:"=%
REM set ACL2=%ACL3:EMPTY=%
REM set ACL={ [%ACL2%] }:
if NOT "%ACL3%" == "EMPTY" (
set ACL={ [%ACL3%] }:
)

set ECF=%3%
set ECF1=%ECF:"=%
set GROUP1=%6%
set GROUP=%GROUP1:"=%
set LABEL1=%7%
set LABEL=%LABEL1:"=%
set ADMIN_EXE_7=admin_execute(%4,$UID,$PWD,$EV,%1,["%8", "%1"],YES);
set ADMIN_EXE_5=admin_execute(%4,$EV,%1,["%8", "%1"],YES);
REM set ARGS=%9%

set ACTION=action '%GROUP%'.'%LABEL%': 
if "%GROUP%" == "EMPTY" (
set ACTION=action '%LABEL%': 
)
REM echo action '%1': >> %TEMP_MRL_FILE%
REM echo action '%GROUP'.'%LABEL': >> %TEMP_MRL_FILE%
echo %ACTION% >> %TEMP_MRL_FILE%
if NOT "X%ACL%" == "X" (
echo %ACL% >> %TEMP_MRL_FILE%
)
echo %ECF1% >> %TEMP_MRL_FILE%
echo { >> %TEMP_MRL_FILE%
echo 	action_requestor($UID,$PWD,$RLT); >> %TEMP_MRL_FILE%
echo 	if ( $RLT == '' ) then # called from IX >> %TEMP_MRL_FILE% 
echo 	{ >> %TEMP_MRL_FILE%
echo 		%ADMIN_EXE_7% >> %TEMP_MRL_FILE%
echo 	} >> %TEMP_MRL_FILE%
echo 	else >> %TEMP_MRL_FILE%
echo 	{ >> %TEMP_MRL_FILE%
echo 		%ADMIN_EXE_5% >> %TEMP_MRL_FILE%
echo 	} >> %TEMP_MRL_FILE%
REM echo admin_execute( %4% , $UID , $PWD , $EV , %1% , ["true"] , YES ); >> %TEMP_MRL_FILE%
echo } >> %TEMP_MRL_FILE%
echo END >> %TEMP_MRL_FILE%
REM type %TEMP_MRL_FILE%

if "%ERRORLEVEL%" == "0" (
	echo Successfully updated the action MRL file %TEMP_MRL_FILE%
	echo Return Code = %ERRORLEVEL%
	goto END
)

if NOT "%ERRORLEVEL%" == "0" (
	echo Failed to update action MRL file %TEMP_MRL_FILE%
	echo Error Code : %ERRORLEVEL%
	goto END
)

:END

