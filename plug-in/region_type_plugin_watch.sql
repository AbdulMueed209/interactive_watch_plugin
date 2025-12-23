prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.11'
,p_default_workspace_id=>4501680284793272963
,p_default_application_id=>125330
,p_default_id_offset=>0
,p_default_owner=>'WKSP_MUEED0321'
);
end;
/
 
prompt APPLICATION 125330 - My Plugins
--
-- Application Export:
--   Application:     125330
--   Name:            My Plugins
--   Date and Time:   12:36 Tuesday December 23, 2025
--   Exported By:     ABDULMUEED209@GMAIL.COM
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 245535379886257202079
--   Manifest End
--   Version:         24.2.11
--   Instance ID:     63113759365424
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/region_type/watch
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(245535379886257202079)
,p_plugin_type=>'REGION TYPE'
,p_name=>'WATCH'
,p_display_name=>'Watch'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render_plugin(',
'    p_region apex_plugin.t_region,',
'    p_plugin apex_plugin.t_plugin,',
'    p_param IN apex_plugin.t_region_render_param,',
'    p_result IN OUT NOCOPY apex_plugin.t_region_render_result',
') AS',
'    l_html            CLOB;',
'    l_dial_color VARCHAR2(20) :=  p_region.attributes.get_varchar2(''dial_color'');',
'    l_hour_marker VARCHAR2(20) :=  p_region.attributes.get_varchar2(''hour_marker'');',
'    l_minute_marker VARCHAR2(20) :=  p_region.attributes.get_varchar2(''minute_marker'');',
'    l_hour_hand VARCHAR2(20) :=  p_region.attributes.get_varchar2(''hour_hand'');',
'    l_minute_hand VARCHAR2(20) :=  p_region.attributes.get_varchar2(''minute_hand'');',
'    l_second_hand VARCHAR2(20) :=  p_region.attributes.get_varchar2(''second_hand'');',
'    l_date_placeholder VARCHAR2(20) :=  p_region.attributes.get_varchar2(''date_placeholder'');',
'    l_date_text VARCHAR2(20) :=  p_region.attributes.get_varchar2(''date_text'');',
'    l_timezone VARCHAR2(20) :=  p_region.attributes.get_varchar2(''timezone'');',
'    l_use_gradient VARCHAR2(20) :=  p_region.attributes.get_varchar2(''use_gradient'');',
'    l_inner_color VARCHAR2(20) :=  p_region.attributes.get_varchar2(''inner_color'');',
'    l_outer_color VARCHAR2(20) :=  p_region.attributes.get_varchar2(''outer_color'');',
'    l_local_timezone VARCHAR2(20) :=  p_region.attributes.get_varchar2(''local_timezone'');',
'',
'BEGIN',
'-- raise_application_error(-20000, l_timezone);',
'APEX_JAVASCRIPT.ADD_LIBRARY(',
'        P_NAME        => ''WatchPlugin'',',
'        P_DIRECTORY   => P_PLUGIN.FILE_PREFIX,',
'        P_VERSION     => NULL',
'    );',
'     ',
'APEX_JAVASCRIPT.ADD_ONLOAD_CODE( ''myRegionInit(''',
'        || APEX_JAVASCRIPT.ADD_VALUE( ''#'' || p_region.static_id, TRUE )',
'        || APEX_JAVASCRIPT.ADD_VALUE( l_dial_color, TRUE )',
'        || APEX_JAVASCRIPT.ADD_VALUE( l_hour_marker, TRUE )',
'        || APEX_JAVASCRIPT.ADD_VALUE( l_minute_marker, TRUE )',
'        || APEX_JAVASCRIPT.ADD_VALUE( l_hour_hand, TRUE )',
'        || APEX_JAVASCRIPT.ADD_VALUE( l_minute_hand, TRUE )',
'        || APEX_JAVASCRIPT.ADD_VALUE( l_second_hand, TRUE )',
'        || APEX_JAVASCRIPT.ADD_VALUE( l_date_placeholder, TRUE )',
'        || APEX_JAVASCRIPT.ADD_VALUE( l_date_text, TRUE )',
'        || APEX_JAVASCRIPT.ADD_VALUE( l_local_timezone, TRUE )',
'        || APEX_JAVASCRIPT.ADD_VALUE( l_timezone, TRUE )',
'        || APEX_JAVASCRIPT.ADD_VALUE( l_use_gradient, TRUE )',
'     || '');'' );',
'',
'l_html := q''[',
'    <div style="display:flex; justify-content:center; align-items:center;">',
'    <svg width="400" height="400" viewBox="-100 -100 200 200" id="watch">',
'        ',
'        <defs>',
'			<radialGradient id="radial_gradient" cx="50%" cy="50%" ',
'							r="50%" fx="50%" fy="50%">			',
'			  <stop offset="0%" style="stop-color:]'' || l_inner_color || q''[; ',
'									   stop-opacity:0" />',
'			  <stop offset="75%" style="stop-color:]'' || l_outer_color || q''[;',
'										 stop-opacity:1" />			  ',
'			</radialGradient>',
'	    </defs>',
'',
'		<!-- Dial -->',
'		<circle id="dial"',
'		cx="0" ',
'		cy="0" ',
'		r="95" ',
'		stroke-width="1" ',
'		fill="none"></circle>',
'',
'		<!-- Date -->',
'		<rect id="date_placeholder" x="50" y="-15" width="15" height="18" fill="white"></rect>',
'		<text x="50" id="datetext">00</text>',
'',
'	  <!-- Minute Marker -->',
'		<circle id="minute_marker"',
'		cx="0" ',
'		cy="0" ',
'		r="90" ',
'		stroke-dasharray="0.2 0.8" ',
'		stroke-dashoffset="0.1" ',
'		stroke="black" ',
'		stroke-width="5" ',
'		pathLength="60" ',
'		fill="none"></circle>',
'	  ',
'	  <!-- Hour Marker -->',
'		<circle id="hour_marker"',
'		cx="0" ',
'		cy="0" ',
'		r="90" ',
'		stroke-dasharray=" 0.05 0.95" ',
'		stroke-dashoffset="0.02" ',
'		stroke="white" ',
'		stroke-width="5" ',
'		pathLength="12" ',
'		fill="none"></circle>',
'	  ',
'		<!-- Hour Hand -->',
'		<g stroke-linecap="round" id="hour_hand">',
'		  <line x1="0" y1="0" x2="0" y2="-50"></line>',
'          <path d="M -1 -10 L -3 -40 Q -1 -45 0 -55 Q 1 -45 3 -40 L 1 -10 Z"></path>',
'		  <circle cx="0" cy="0" r="2" stroke-width=".5" fill="none"></circle>',
'		</g>',
'',
'		<!-- Minute Hand -->',
'		<g stroke-linecap="round" id="minute_hand">',
'			<line x1="0" y1="0" x2="0" y2="-65"></line>',
'            <path d="M -1 -10 L -2 -55 Q -1 -60 0 -70 Q 1 -60 2 -55 L 1 -10 Z"></path>',
'			<circle cx="0" cy="0" r="2" stroke-width=".5" fill="none"></circle>',
'		</g>',
'',
'		<!-- Second Hand -->',
'		<g stroke-linecap="round" id="second_hand">',
'			<line x1="0" y1="10" x2="0" y2="-75"></line>',
'			<circle cx="0" cy="0" r="2" stroke-width=".5" fill="none"></circle>',
'		</g>',
'	  </svg>',
'      </div>]'';',
'      htp.p(l_html);',
'',
'END;'))
,p_api_version=>3
,p_render_function=>'render_plugin'
,p_substitute_attributes=>true
,p_version_scn=>15686881626451
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_files_version=>116
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(245562035977065855562)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_title=>'Colors'
,p_display_sequence=>1
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(245872656677492699807)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_title=>'Gradient'
,p_display_sequence=>2
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245562126576746861843)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'dial_color'
,p_prompt=>'Dial Color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#ffc3c3'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(245562035977065855562)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245562205454916868381)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'hour_marker'
,p_prompt=>'Hour Marker'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#ffffff'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(245562035977065855562)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245562242311004870819)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'minute_marker'
,p_prompt=>'Minute Marker'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#4a4a4a'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(245562035977065855562)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245562412561508187028)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'hour_hand'
,p_prompt=>'Hour Hand'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#f7c455'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(245562035977065855562)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245563752183374916259)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'minute_hand'
,p_prompt=>'Minute Hand'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#fcc41b'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(245562035977065855562)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245562757764105191815)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'second_hand'
,p_prompt=>'Second Hand'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#d98a02'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(245562035977065855562)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245562594365580881722)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_static_id=>'date_placeholder'
,p_prompt=>'Date Placeholder'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#ffffff'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(245562035977065855562)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245570619671004453288)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'date_text'
,p_prompt=>'Date Text'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#000000'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(245562035977065855562)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245845871339851292163)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>130
,p_static_id=>'timezone'
,p_prompt=>'Timezone'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'America/New_York'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(245921203479332025916)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'N'
,p_lov_type=>'STATIC'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245854496877609773254)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>10
,p_display_value=>'UTC'
,p_return_value=>'UTC'
,p_is_quick_pick=>true
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245846290196242616753)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>20
,p_display_value=>'Asia/Karachi'
,p_return_value=>'Asia/Karachi'
,p_is_quick_pick=>true
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245854976942516460347)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>30
,p_display_value=>'Asia/Kolkata'
,p_return_value=>'Asia/Kolkata'
,p_is_quick_pick=>true
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245854985110167461093)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>40
,p_display_value=>'Asia/Dubai'
,p_return_value=>'Asia/Dubai'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245854588378183775430)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>50
,p_display_value=>'Asia/Riyadh'
,p_return_value=>'Asia/Riyadh'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245854991543261462393)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>60
,p_display_value=>'Europe/London'
,p_return_value=>'Europe/London'
,p_is_quick_pick=>true
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245854992615520463049)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>70
,p_display_value=>'Europe/Paris'
,p_return_value=>'Europe/Paris'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245855316121792777308)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>80
,p_display_value=>'America/New_York'
,p_return_value=>'America/New_York'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245855324508053777819)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>90
,p_display_value=>'America/Chicago'
,p_return_value=>'America/Chicago'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245855018863440464699)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>100
,p_display_value=>'America/Denver'
,p_return_value=>'America/Denver'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245855027683167465257)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>110
,p_display_value=>'America/Los_Angeles'
,p_return_value=>'America/Los_Angeles'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(245855033069082465978)
,p_plugin_attribute_id=>wwv_flow_imp.id(245845871339851292163)
,p_display_sequence=>120
,p_display_value=>'Australia/Sydney'
,p_return_value=>'Australia/Sydney'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245873503362372710291)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_static_id=>'use_gradient'
,p_prompt=>'Use Gradient'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(245872656677492699807)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245873882807641027114)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_static_id=>'inner_color'
,p_prompt=>'Inner Color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#edde52'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(245873503362372710291)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(245872656677492699807)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245874149627466715864)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_static_id=>'outer_color'
,p_prompt=>'Outer Color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_default_value=>'#57c785'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(245873503362372710291)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(245872656677492699807)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(245921203479332025916)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>90
,p_static_id=>'local_timezone'
,p_prompt=>'Local Timezone'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '76617220765F74696D657A6F6E653B0D0A76617220765F7573655F6772616469656E743B0D0A766172206D79526567696F6E496E6974203D2066756E6374696F6E28726567696F6E5F69642C6469616C5F636F6C6F722C686F75725F6D61726B65722C6D';
wwv_flow_imp.g_varchar2_table(2) := '696E7574655F6D61726B65722C686F75725F68616E640D0A2C6D696E7574655F68616E642C7365636F6E645F68616E642C646174655F706C616365686F6C6465722C646174655F746578742C0D0A6C6F63616C5F74696D657A6F6E655F666C61672C7469';
wwv_flow_imp.g_varchar2_table(3) := '6D657A6F6E652C7573655F6772616469656E740D0A29207B0D0A202020206966287573655F6772616469656E74203D3D3D20275927297B0D0A2020202020202020646F63756D656E742E676574456C656D656E744279496428276469616C27292E736574';
wwv_flow_imp.g_varchar2_table(4) := '417474726962757465282766696C6C272C202775726C282372616469616C5F6772616469656E742927293B202020200D0A202020207D0D0A20202020656C7365207B0D0A2020202020202020646F63756D656E742E676574456C656D656E744279496428';
wwv_flow_imp.g_varchar2_table(5) := '276469616C27292E736574417474726962757465282766696C6C272C206469616C5F636F6C6F72293B0D0A202020207D0D0A20202020646F63756D656E742E676574456C656D656E74427949642827686F75725F6D61726B657227292E73657441747472';
wwv_flow_imp.g_varchar2_table(6) := '696275746528277374726F6B65272C20686F75725F6D61726B6572293B0D0A20202020646F63756D656E742E676574456C656D656E744279496428276D696E7574655F6D61726B657227292E73657441747472696275746528277374726F6B65272C206D';
wwv_flow_imp.g_varchar2_table(7) := '696E7574655F6D61726B6572293B0D0A20202020646F63756D656E742E676574456C656D656E74427949642827686F75725F68616E6427292E73657441747472696275746528277374726F6B65272C20686F75725F68616E64293B0D0A20202020646F63';
wwv_flow_imp.g_varchar2_table(8) := '756D656E742E676574456C656D656E74427949642827686F75725F68616E6427292E736574417474726962757465282766696C6C272C20686F75725F68616E64293B0D0A20202020646F63756D656E742E676574456C656D656E744279496428276D696E';
wwv_flow_imp.g_varchar2_table(9) := '7574655F68616E6427292E73657441747472696275746528277374726F6B65272C206D696E7574655F68616E64293B0D0A20202020646F63756D656E742E676574456C656D656E744279496428276D696E7574655F68616E6427292E7365744174747269';
wwv_flow_imp.g_varchar2_table(10) := '62757465282766696C6C272C206D696E7574655F68616E64293B0D0A20202020646F63756D656E742E676574456C656D656E744279496428277365636F6E645F68616E6427292E73657441747472696275746528277374726F6B65272C207365636F6E64';
wwv_flow_imp.g_varchar2_table(11) := '5F68616E64293B0D0A20202020646F63756D656E742E676574456C656D656E74427949642827646174655F706C616365686F6C64657227292E736574417474726962757465282766696C6C272C20646174655F706C616365686F6C646572293B0D0A2020';
wwv_flow_imp.g_varchar2_table(12) := '2020646F63756D656E742E676574456C656D656E74427949642827646174657465787427292E736574417474726962757465282766696C6C272C20646174655F74657874293B0D0A202020206966286C6F63616C5F74696D657A6F6E655F666C6167203D';
wwv_flow_imp.g_varchar2_table(13) := '3D3D20275927297B0D0A20202020765F74696D657A6F6E65203D20496E746C2E4461746554696D65466F726D617428292E7265736F6C7665644F7074696F6E7328292E74696D655A6F6E653B0D0A202020207D0D0A20202020656C7365207B0D0A202020';
wwv_flow_imp.g_varchar2_table(14) := '20765F74696D657A6F6E65203D2074696D657A6F6E653B0D0A202020207D0D0A7D3B0D0A0D0A66756E6374696F6E20757064617465576174636828297B202020200D0A09090976617220696E697469616C5F74696D65203D206E6577204461746528293B';
wwv_flow_imp.g_varchar2_table(15) := '0D0A2020202020202020202020207661722074696D65203D206E65772044617465280D0A20202020202020202020202020202020696E697469616C5F74696D652E746F4C6F63616C65537472696E672822656E2D5553222C207B2074696D655A6F6E653A';
wwv_flow_imp.g_varchar2_table(16) := '20765F74696D657A6F6E65207D290D0A202020202020202020202020293B0D0A20202020202020202020202074696D652E7365744D696C6C697365636F6E647328696E697469616C5F74696D652E6765744D696C6C697365636F6E64732829293B0D0A09';
wwv_flow_imp.g_varchar2_table(17) := '0909636F6E73742064617465203D2074696D652E6765744461746528293B0D0A090909636F6E737420686F757273203D2074696D652E676574486F75727328293B0D0A090909636F6E7374206D696E75746573203D2074696D652E6765744D696E757465';
wwv_flow_imp.g_varchar2_table(18) := '7328293B0D0A090909636F6E7374207365636F6E6473203D2074696D652E6765745365636F6E647328293B0D0A202020202020202020202020636F6E7374206D696C697365636F6E64203D2074696D652E6765744D696C6C697365636F6E647328293B0D';
wwv_flow_imp.g_varchar2_table(19) := '0A090909636F6E737420686F75725F616E676C65203D20283336302F3132292A2828686F75727325313229202B20286D696E757465732F363029293B0D0A090909636F6E7374206D696E7574655F616E676C65203D20283336302F3630292A286D696E75';
wwv_flow_imp.g_varchar2_table(20) := '746573202B20287365636F6E64732F363029293B0D0A090909636F6E7374207365636F6E645F616E676C65203D20283336302F3630292A7365636F6E6473202B20286D696C697365636F6E642F313030302A36293B0D0A090909646F63756D656E742E67';
wwv_flow_imp.g_varchar2_table(21) := '6574456C656D656E74427949642827686F75725F68616E6427292E73657441747472696275746528277472616E73666F726D272C2060726F7461746528247B686F75725F616E676C657D2960293B0D0A090909646F63756D656E742E676574456C656D65';
wwv_flow_imp.g_varchar2_table(22) := '6E744279496428276D696E7574655F68616E6427292E73657441747472696275746528277472616E73666F726D272C2060726F7461746528247B6D696E7574655F616E676C657D2960293B0D0A090909646F63756D656E742E676574456C656D656E7442';
wwv_flow_imp.g_varchar2_table(23) := '79496428277365636F6E645F68616E6427292E73657441747472696275746528277472616E73666F726D272C2060726F7461746528247B7365636F6E645F616E676C657D2960293B0D0A090909646F63756D656E742E676574456C656D656E7442794964';
wwv_flow_imp.g_varchar2_table(24) := '2827646174657465787427292E74657874436F6E74656E74203D20646174653B0D0A09090972657175657374416E696D6174696F6E4672616D65287570646174655761746368293B0D0A09097D0D0A72657175657374416E696D6174696F6E4672616D65';
wwv_flow_imp.g_varchar2_table(25) := '287570646174655761746368293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(245542821113398398496)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_file_name=>'WatchPlugin.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '76617220765F74696D657A6F6E652C765F7573655F6772616469656E742C6D79526567696F6E496E69743D66756E6374696F6E28742C652C6E2C642C6F2C692C6D2C722C752C612C6C2C73297B2259223D3D3D733F646F63756D656E742E676574456C65';
wwv_flow_imp.g_varchar2_table(2) := '6D656E744279496428226469616C22292E736574417474726962757465282266696C6C222C2275726C282372616469616C5F6772616469656E742922293A646F63756D656E742E676574456C656D656E744279496428226469616C22292E736574417474';
wwv_flow_imp.g_varchar2_table(3) := '726962757465282266696C6C222C65292C646F63756D656E742E676574456C656D656E74427949642822686F75725F6D61726B657222292E73657441747472696275746528227374726F6B65222C6E292C646F63756D656E742E676574456C656D656E74';
wwv_flow_imp.g_varchar2_table(4) := '4279496428226D696E7574655F6D61726B657222292E73657441747472696275746528227374726F6B65222C64292C646F63756D656E742E676574456C656D656E74427949642822686F75725F68616E6422292E73657441747472696275746528227374';
wwv_flow_imp.g_varchar2_table(5) := '726F6B65222C6F292C646F63756D656E742E676574456C656D656E74427949642822686F75725F68616E6422292E736574417474726962757465282266696C6C222C6F292C646F63756D656E742E676574456C656D656E744279496428226D696E757465';
wwv_flow_imp.g_varchar2_table(6) := '5F68616E6422292E73657441747472696275746528227374726F6B65222C69292C646F63756D656E742E676574456C656D656E744279496428226D696E7574655F68616E6422292E736574417474726962757465282266696C6C222C69292C646F63756D';
wwv_flow_imp.g_varchar2_table(7) := '656E742E676574456C656D656E744279496428227365636F6E645F68616E6422292E73657441747472696275746528227374726F6B65222C6D292C646F63756D656E742E676574456C656D656E74427949642822646174655F706C616365686F6C646572';
wwv_flow_imp.g_varchar2_table(8) := '22292E736574417474726962757465282266696C6C222C72292C646F63756D656E742E676574456C656D656E74427949642822646174657465787422292E736574417474726962757465282266696C6C222C75292C765F74696D657A6F6E653D2259223D';
wwv_flow_imp.g_varchar2_table(9) := '3D3D613F496E746C2E4461746554696D65466F726D617428292E7265736F6C7665644F7074696F6E7328292E74696D655A6F6E653A6C7D3B66756E6374696F6E20757064617465576174636828297B76617220743D6E657720446174652C653D6E657720';
wwv_flow_imp.g_varchar2_table(10) := '4461746528742E746F4C6F63616C65537472696E672822656E2D5553222C7B74696D655A6F6E653A765F74696D657A6F6E657D29293B652E7365744D696C6C697365636F6E647328742E6765744D696C6C697365636F6E64732829293B636F6E7374206E';
wwv_flow_imp.g_varchar2_table(11) := '3D652E6765744461746528292C643D652E676574486F75727328292C6F3D652E6765744D696E7574657328292C693D652E6765745365636F6E647328292C6D3D33302A28642531322B6F2F3630292C723D362A286F2B692F3630292C753D362A692B652E';
wwv_flow_imp.g_varchar2_table(12) := '6765744D696C6C697365636F6E647328292F3165332A363B646F63756D656E742E676574456C656D656E74427949642822686F75725F68616E6422292E73657441747472696275746528227472616E73666F726D222C60726F7461746528247B6D7D2960';
wwv_flow_imp.g_varchar2_table(13) := '292C646F63756D656E742E676574456C656D656E744279496428226D696E7574655F68616E6422292E73657441747472696275746528227472616E73666F726D222C60726F7461746528247B727D2960292C646F63756D656E742E676574456C656D656E';
wwv_flow_imp.g_varchar2_table(14) := '744279496428227365636F6E645F68616E6422292E73657441747472696275746528227472616E73666F726D222C60726F7461746528247B757D2960292C646F63756D656E742E676574456C656D656E74427949642822646174657465787422292E7465';
wwv_flow_imp.g_varchar2_table(15) := '7874436F6E74656E743D6E2C72657175657374416E696D6174696F6E4672616D65287570646174655761746368297D72657175657374416E696D6174696F6E4672616D65287570646174655761746368293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(245921869531873060442)
,p_plugin_id=>wwv_flow_imp.id(245535379886257202079)
,p_file_name=>'WatchPlugin.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
