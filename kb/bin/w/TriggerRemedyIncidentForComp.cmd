REM #################################################################################
REM # BMC Impact Integration for ARS
REM # Date			: March 08, 2005
REM # Author		: SMS Pune Integration Connect Team
REM # Description	: Executable for remote aciton "Trigger Remedy Incident For Component"					
REM # Revision		: 		
# Copyright 1998-2009 BMC Software, Inc.  All rights reserved.
REM #################################################################################

REM #Remote Action will work on only event of type class SIM_COMPONENT_CHANGE

if %CLASS% == SIM_COMPONENT_CHANGE mposter -a IBRSD_REMOTE_ACTION -n %cell_name% -r '%severity%' -m "Remote Action for component %component_udid%" -b comp_id='%component_udid%';comp_status='%component_status%';comp_priority='%computed_priority%';comp_cost=%cost%;root_causes=%root_causes%;prop_destination=[%1];status=%status%;
