// ╔══════════════════════════════════════╗
// ║           SAMP FILTER SCRIPT         ║
// ║          Squid Game Project          ║
// ║            by SMK 'yoalsaki'              ║
// ║        Style inspired by Dev SMK     ║
// ╚══════════════════════════════════════╝
//
// Description:
//   - This script uses streamer plugin
//   - Includes Squid Game timer logic
//   - Object and map handling
//
// Enjoy scripting and stay safe!
// ──────────────────────────────────────

/*
129.718307, 1106.749023, 1084.078735 //room 0

and you can goto the rooms /gotoco /gotocordones
*/

#include <a_samp>
#include streamer

new tmpobjid;
new sq_map;

// Squid Game Timer Variables
new squidGameTimer = -1;
new squidGameTime = 0;
new squidGameActive = 0;
new Text:squidGameDisplay = Text:INVALID_TEXT_DRAW;

#if defined _fixobject_included
    #endinput
#endif
#define _fixobject_included

stock ffo_CreateObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:DrawDistance = 300.0) return CreateObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, DrawDistance);
stock ffo_SetObjectMaterial(objectid, materialindex, modelid, txdname[], texturename[], materialcolor = 0) return SetObjectMaterial(objectid, materialindex, modelid, txdname, texturename, materialcolor);
stock ffo_SetPlayerObjectMaterial(playerid, objectid, materialindex, modelid, txdname[], texturename[], materialcolor = 0) return SetPlayerObjectMaterial(playerid, objectid, materialindex, modelid, txdname, texturename, materialcolor);

stock fo_CreateDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 300.0, Float:drawdistance = 300.0, areaid = -1, priority = 0)
{
    if(streamdistance < 100.0) streamdistance = 100.0;
    else if(streamdistance > 600.0) streamdistance = 600.0;
    return CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority);
}
#if defined _ALS_CreateDynamicObject
    #undef CreateDynamicObject
#else
    #define _ALS_CreateDynamicObject
#endif
#define CreateDynamicObject fo_CreateDynamicObject

stock fo_CreateDynamicObjectEx(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:streamdistance = 300.0, Float:drawdistance = 300.0, worlds[] = { -1 }, interiors[] = { -1 }, players[] = { -1 }, areas[] = { -1 }, priority = 0, maxworlds = sizeof worlds, maxinteriors = sizeof interiors, maxplayers = sizeof players, maxareas = sizeof areas)
{
    if(streamdistance < 100.0) streamdistance = 100.0;
    else if(streamdistance > 600.0) streamdistance = 600.0;
    return CreateDynamicObjectEx(modelid, x, y, z, rx, ry, rz, streamdistance, drawdistance, worlds, interiors, players, areas, priority, maxworlds, maxinteriors, maxplayers, maxareas);
}
#if defined _ALS_CreateDynamicObjectEx
    #undef CreateDynamicObjectEx
#else
    #define _ALS_CreateDynamicObjectEx
#endif
#define CreateDynamicObjectEx fo_CreateDynamicObjectEx

stock fo_CreateObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:DrawDistance = 300.0) return CreateDynamicObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, -1, -1, -1, 300.0, DrawDistance);
#if defined _ALS_CreateObject
    #undef CreateObject
#else
    #define _ALS_CreateObject
#endif
#define CreateObject fo_CreateObject

stock fo_DestroyObject(objectid) return DestroyDynamicObject(objectid);
#if defined _ALS_DestroyObject
    #undef DestroyObject
#else
    #define _ALS_DestroyObject
#endif
#define DestroyObject fo_DestroyObject

stock fo_SetObjectMaterialText(objectid, text[], materialindex = 0, materialsize = OBJECT_MATERIAL_SIZE_256x128, fontface[] = "Arial", fontsize = 24, bold = 1, fontcolor = 0xFFFFFFFF, backcolor = 0, textalignment = 0) return SetDynamicObjectMaterialText(objectid, materialindex, text, materialsize, fontface, fontsize, bold, fontcolor, backcolor, textalignment);
#if defined _ALS_SetObjectMaterialText
    #undef SetObjectMaterialText
#else
    #define _ALS_SetObjectMaterialText
#endif
#define SetObjectMaterialText fo_SetObjectMaterialText

stock fo_GetObjectModel(objectid) return Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_MODEL_ID);
#if defined _ALS_GetObjectModel
    #undef GetObjectModel
#else
    #define _ALS_GetObjectModel
#endif
#define GetObjectModel fo_GetObjectModel

#if defined _ALS_AttachObjectToVehicle
    #undef AttachObjectToVehicle
#else
    #define _ALS_AttachObjectToVehicle
#endif
#define AttachObjectToVehicle AttachDynamicObjectToVehicle

#if defined _ALS_AttachObjectToObject
    #undef AttachObjectToObject
#else
    #define _ALS_AttachObjectToObject
#endif
#define AttachObjectToObject AttachDynamicObjectToObject

#if defined _ALS_AttachObjectToPlayer
    #undef AttachObjectToPlayer
#else
    #define _ALS_AttachObjectToPlayer
#endif
#define AttachObjectToPlayer AttachDynamicObjectToPlayer

#if defined _ALS_SetObjectPos
    #undef SetObjectPos
#else
    #define _ALS_SetObjectPos
#endif
#define SetObjectPos SetDynamicObjectPos

#if defined _ALS_GetObjectPos
    #undef GetObjectPos
#else
    #define _ALS_GetObjectPos
#endif
#define GetObjectPos GetDynamicObjectPos

#if defined _ALS_SetObjectRot
    #undef SetObjectRot
#else
    #define _ALS_SetObjectRot
#endif
#define SetObjectRot SetDynamicObjectRot

#if defined _ALS_GetObjectRot
    #undef GetObjectRot
#else
    #define _ALS_GetObjectRot
#endif
#define GetObjectRot GetDynamicObjectRot

#if defined _ALS_SetObjectNoCameraCol
    #undef SetObjectNoCameraCol
#else
    #define _ALS_SetObjectNoCameraCol
#endif
#define SetObjectNoCameraCol SetDynamicObjectNoCameraCol

#if defined _ALS_IsValidObject
    #undef IsValidObject
#else
    #define _ALS_IsValidObject
#endif
#define IsValidObject IsValidDynamicObject

#if defined _ALS_MoveObject
    #undef MoveObject
#else
    #define _ALS_MoveObject
#endif
#define MoveObject MoveDynamicObject

#if defined _ALS_StopObject
    #undef StopObject
#else
    #define _ALS_StopObject
#endif
#define StopObject StopDynamicObject

#if defined _ALS_IsObjectMoving
    #undef IsObjectMoving
#else
    #define _ALS_IsObjectMoving
#endif
#define IsObjectMoving IsDynamicObjectMoving

#if defined _ALS_EditObject
    #undef EditObject
#else
    #define _ALS_EditObject
#endif
#define EditObject EditDynamicObject

#if defined _ALS_SetObjectMaterial
    #undef SetObjectMaterial
#else
    #define _ALS_SetObjectMaterial
#endif
#define SetObjectMaterial SetDynamicObjectMaterial

public OnFilterScriptInit()
{
//squidgame room 0
CreateDynamicObject(19545, 149.82288, 1106.92468, 1082.97180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19545, 134.82663, 1106.92261, 1082.97180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19545, 104.85250, 1106.86841, 1082.97180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19545, 119.84787, 1106.81689, 1082.97180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18995, 129.21809, 1078.43250, 1085.29675,   -90.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, 111.93510, 1081.34045, 1095.39136,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19369, 123.42437, 1077.47900, 1084.34180,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 132.89310, 1077.48364, 1084.34180,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 129.75011, 1077.48364, 1084.34180,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 126.60710, 1077.48364, 1084.34180,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 123.46410, 1078.20959, 1084.18774,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 126.65010, 1078.20959, 1084.18774,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 129.69380, 1078.21277, 1084.18774,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 132.72110, 1078.20959, 1084.18774,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 123.46410, 1078.80457, 1084.02771,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 126.61410, 1078.80457, 1084.02771,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 129.76410, 1078.80457, 1084.02771,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 132.91409, 1078.80457, 1084.02771,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 123.46410, 1079.33862, 1083.84973,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 123.46410, 1078.80457, 1084.02771,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 126.59010, 1079.33862, 1083.84973,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 129.63710, 1079.33862, 1083.84973,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 132.68410, 1079.33862, 1083.84973,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 132.68410, 1079.89258, 1083.64575,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 132.68410, 1080.41760, 1083.46570,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 132.68410, 1080.85864, 1083.27673,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 132.68410, 1081.08960, 1083.08765,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 129.54111, 1079.89258, 1083.64575,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 126.39810, 1079.89258, 1083.64575,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 123.25510, 1079.89258, 1083.64575,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 129.54111, 1080.41760, 1083.46570,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 126.39810, 1080.41760, 1083.46570,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 123.27320, 1080.37659, 1083.46570,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 129.54111, 1080.85864, 1083.27673,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 126.39810, 1080.85864, 1083.27673,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 123.25658, 1080.87854, 1083.27673,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 129.54111, 1081.08960, 1083.08765,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 126.39810, 1081.08960, 1083.08765,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19369, 123.25510, 1081.08960, 1083.08765,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(18981, 146.45380, 1081.33936, 1095.18335,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, 111.95509, 1082.38086, 1095.39136,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, 146.47345, 1082.35901, 1095.18335,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, 156.60381, 1093.25134, 1095.18335,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, 156.60381, 1118.19153, 1095.18335,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, 156.60381, 1125.72742, 1095.18335,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, 144.60181, 1137.37634, 1095.18335,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, 119.89180, 1137.37634, 1095.18335,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, 110.00780, 1137.37634, 1095.18335,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, 100.12380, 1093.25134, 1095.31226,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, 100.10388, 1117.60645, 1095.18335,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, 100.10390, 1126.07837, 1095.18335,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19362, 134.35010, 1080.81335, 1090.12024,   55.00000, 0.00000, 90.00000);
CreateDynamicObject(19362, 132.50410, 1080.81335, 1091.39832,   113.00000, 0.00000, 90.00000);
CreateDynamicObject(19362, 129.38010, 1080.81335, 1092.10828,   91.00000, 0.00000, 90.00000);
CreateDynamicObject(19362, 126.96610, 1080.81335, 1091.54028,   69.00000, 0.00000, 90.00000);
CreateDynamicObject(19362, 125.12010, 1080.81335, 1090.97229,   55.00000, 0.00000, 90.00000);
CreateDynamicObject(19362, 124.55210, 1080.81335, 1090.26233,   40.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, 128.17110, 1080.53247, 1104.27954,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, 109.01180, 1093.25134, 1107.30334,   0.00000, 55.00000, 0.00000);
CreateDynamicObject(18981, 108.99080, 1118.15735, 1107.30334,   0.00000, 55.00000, 0.00000);
CreateDynamicObject(18981, 109.01180, 1125.57129, 1107.30334,   0.00000, 55.00000, 0.00000);
CreateDynamicObject(18981, 147.81511, 1093.24609, 1107.30334,   0.00000, -55.00000, 0.00000);
CreateDynamicObject(18981, 147.80930, 1118.19019, 1107.30334,   0.00000, -55.00000, 0.00000);
CreateDynamicObject(18981, 147.81509, 1125.56604, 1107.30334,   0.00000, -55.00000, 0.00000);
CreateDynamicObject(18981, 128.82710, 1118.08301, 1114.17126,   0.00000, -90.00000, 0.00000);
CreateDynamicObject(18981, 128.82710, 1093.24597, 1114.17126,   0.00000, -90.00000, 0.00000);
CreateDynamicObject(18981, 128.82710, 1126.37402, 1114.17126,   0.00000, -90.00000, 0.00000);
CreateDynamicObject(18981, 128.77980, 1137.37634, 1102.05127,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18995, 129.21800, 1073.99133, 1085.29675,   -90.00000, 0.00000, 0.00000);
CreateDynamicObject(19369, 128.02150, 1073.99133, 1084.34180,   0.00000, -90.00000, 90.00000);
CreateDynamicObject(19369, 124.79810, 1073.98303, 1084.34180,   0.00000, -90.00000, 90.00000);
CreateDynamicObject(19369, 131.23270, 1073.99133, 1084.34180,   0.00000, -90.00000, 90.00000);
CreateDynamicObject(19369, 134.44350, 1073.98779, 1084.34180,   0.00000, -90.00000, 90.00000);
CreateDynamicObject(19370, 129.78500, 1097.73743, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 132.99899, 1097.73779, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 126.57700, 1097.73743, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 129.78500, 1101.19141, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 129.78500, 1104.69336, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 129.78500, 1108.19543, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 129.78500, 1111.69739, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 126.57700, 1101.23938, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 126.57700, 1104.74146, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 126.57880, 1108.22351, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 126.57492, 1111.72546, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 132.99899, 1101.23975, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 132.99899, 1104.74182, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 132.99899, 1108.24377, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 132.99899, 1111.74585, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 129.78500, 1115.19934, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 129.78500, 1118.70142, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 126.57490, 1115.22754, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 126.57490, 1118.72949, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 132.99899, 1115.24780, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 132.99899, 1118.74976, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(1801, 107.75682, 1097.47949, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.74000, 1103.82642, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.69319, 1114.76746, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.73672, 1105.70056, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.69320, 1114.76746, 1084.10413,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.69320, 1114.76746, 1085.13416,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.69320, 1114.76746, 1086.16406,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.69320, 1114.76746, 1086.98816,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.69320, 1114.76746, 1087.81213,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.72810, 1105.71863, 1083.89807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.72810, 1105.71863, 1084.72205,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.72810, 1105.71863, 1085.54614,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.72810, 1105.71863, 1086.37012,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.72810, 1105.71863, 1087.19409,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.72810, 1105.71863, 1088.01807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.74000, 1103.82642, 1083.89807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.74000, 1103.82642, 1084.72205,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.74000, 1103.82642, 1085.54614,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.74000, 1103.82642, 1086.37012,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.74000, 1103.82642, 1087.19409,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.74000, 1103.82642, 1088.01807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.80650, 1097.52063, 1083.89807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.80650, 1097.52063, 1084.72205,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.80650, 1097.52063, 1085.54614,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.80650, 1097.52063, 1086.37012,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.80650, 1097.52063, 1087.19409,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 107.80650, 1097.52063, 1087.81213,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.21200, 1103.82642, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68400, 1103.82642, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.15600, 1103.82642, 1083.89807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.15600, 1103.82642, 1084.72205,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.15600, 1103.82642, 1085.54614,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.15600, 1103.82642, 1086.37012,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.15600, 1103.82642, 1087.19409,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68400, 1103.82642, 1083.89807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68400, 1103.82642, 1084.72205,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68400, 1103.82642, 1085.54614,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68400, 1103.82642, 1086.37012,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68400, 1103.82642, 1087.19409,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68400, 1103.82642, 1087.81213,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.13554, 1103.79199, 1087.81213,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.21200, 1103.82642, 1083.89807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.21200, 1103.82642, 1084.72205,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.21200, 1103.82642, 1085.54614,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.21200, 1103.82642, 1086.37012,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.21200, 1103.82642, 1087.19409,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.21200, 1103.82642, 1088.01807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.17375, 1103.83557, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.20870, 1105.70056, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68722, 1105.71948, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.15270, 1105.70056, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.15270, 1105.70056, 1084.10413,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.15270, 1105.70056, 1085.13416,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.15270, 1105.70056, 1086.16406,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.15270, 1105.70056, 1087.19409,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.15270, 1105.70056, 1088.01807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68720, 1105.71948, 1084.10413,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68720, 1105.71948, 1085.13416,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68720, 1105.71948, 1085.95813,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68720, 1105.71948, 1086.98816,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.68720, 1105.71948, 1087.81213,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.20870, 1105.70056, 1083.89807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.20870, 1105.70056, 1084.92810,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.20870, 1105.70056, 1085.95813,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.20870, 1105.70056, 1086.98816,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.20870, 1105.70056, 1088.01807,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1437, 112.33760, 1101.97644, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 110.11060, 1101.97644, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 104.82160, 1101.97644, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 107.40460, 1101.97644, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1801, 110.18620, 1114.76746, 1082.99414,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.67920, 1114.76746, 1082.99414,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.17220, 1114.76746, 1082.99414,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.17220, 1114.76746, 1083.99915,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.67920, 1114.76746, 1084.03809,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.18620, 1114.76746, 1084.03809,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.18620, 1114.76746, 1084.90808,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.18620, 1114.76746, 1085.95215,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.18620, 1114.76746, 1086.99609,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.65920, 1114.76709, 1085.08215,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.65920, 1114.76709, 1085.95215,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.65920, 1114.76709, 1086.82214,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.17220, 1114.76746, 1085.04309,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.17220, 1114.76746, 1086.08716,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.17220, 1114.76746, 1087.13110,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.18620, 1114.76746, 1088.04004,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.65920, 1114.76709, 1087.86597,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.17220, 1114.76746, 1088.17505,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.36680, 1097.47949, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.97680, 1097.47949, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.58439, 1097.49939, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.36680, 1097.47949, 1084.11804,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.36680, 1097.47949, 1085.16211,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.36680, 1097.47949, 1086.20605,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.36680, 1097.47949, 1087.25012,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 110.36680, 1097.47949, 1088.29407,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.97680, 1097.47949, 1084.11804,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.97680, 1097.47949, 1085.16199,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.97680, 1097.47949, 1086.20605,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.97680, 1097.47949, 1087.25000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 112.97680, 1097.47949, 1088.29395,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.58440, 1097.49939, 1084.11804,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.58440, 1097.49939, 1085.16211,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.58440, 1097.49939, 1086.20605,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.58440, 1097.49939, 1087.25012,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 115.58440, 1097.49939, 1088.29407,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.36931, 1097.73999, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.96404, 1097.75293, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.60222, 1097.75525, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.19930, 1097.73999, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.31450, 1105.89819, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.34068, 1104.12988, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.17258, 1115.02600, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.71880, 1115.02307, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.31880, 1115.02307, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.77879, 1115.02307, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.85390, 1105.92017, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.98990, 1105.92017, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.90871, 1104.12988, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.47670, 1104.12988, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.04807, 1104.11023, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.19257, 1115.02722, 1084.03516,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.71880, 1115.02307, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.31880, 1115.02307, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.77879, 1115.02307, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.77879, 1115.02307, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.31880, 1115.02307, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.77879, 1115.02307, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.77879, 1115.02307, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.77879, 1115.02307, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.31880, 1115.02307, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.31880, 1115.02307, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.31880, 1115.02307, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.71880, 1115.02307, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.71880, 1115.02307, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.71880, 1115.02307, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.71880, 1115.02307, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.19260, 1115.02722, 1084.98718,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.19260, 1115.02722, 1085.93921,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.19260, 1115.02722, 1086.89124,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.19260, 1115.02722, 1087.84314,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.04810, 1104.11023, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.04810, 1104.11023, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.04810, 1104.11023, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.04810, 1104.11023, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.04810, 1104.11023, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.47670, 1104.12988, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.47670, 1104.12988, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.47670, 1104.12988, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.47670, 1104.12988, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.47670, 1104.12988, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.19930, 1097.73999, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.19930, 1097.73999, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.19930, 1097.73999, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.19930, 1097.73999, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 156.19930, 1097.73999, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.60220, 1097.75525, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.96400, 1097.75293, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.60220, 1097.75525, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.60220, 1097.75525, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.60220, 1097.75525, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.60220, 1097.75525, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.96400, 1097.75293, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.96400, 1097.75293, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.96400, 1097.75293, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.96400, 1097.75293, 1087.69812,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.98990, 1105.92017, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.98990, 1105.92017, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.98990, 1105.92017, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.98990, 1105.92017, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 155.98990, 1105.92017, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.42191, 1105.92017, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.42191, 1105.92017, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.42191, 1105.92017, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.42191, 1105.92017, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.42191, 1105.92017, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 153.42191, 1105.92017, 1083.07410,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.36929, 1097.73999, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.36929, 1097.73999, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.36929, 1097.73999, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.36929, 1097.73999, 1086.74609,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.36929, 1097.73999, 1087.69812,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.90871, 1104.12988, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.90871, 1104.12988, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.90871, 1104.12988, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.90871, 1104.12988, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.90871, 1104.12988, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.85390, 1105.92017, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.85390, 1105.92017, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.85390, 1105.92017, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.85390, 1105.92017, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 150.85390, 1105.92017, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.34070, 1104.12988, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.31450, 1105.89819, 1084.02612,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.31450, 1105.89819, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.31450, 1105.89819, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.31450, 1105.89819, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.31450, 1105.89819, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.34070, 1104.12988, 1084.97815,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.34070, 1104.12988, 1085.93005,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.34070, 1104.12988, 1086.88208,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1801, 148.34070, 1104.12988, 1087.83411,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1437, 112.33760, 1112.72046, 1084.13684,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 110.02560, 1112.72046, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 107.57760, 1112.72046, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 104.99360, 1112.85645, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 104.99360, 1108.36853, 1083.86475,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 107.44160, 1108.36853, 1083.86475,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 109.88960, 1108.36853, 1083.72876,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 112.47360, 1108.36853, 1083.86475,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 112.88160, 1099.89648, 1084.00085,   22.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 110.18560, 1099.88049, 1084.00085,   22.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 107.57760, 1099.84045, 1084.00085,   22.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 104.99360, 1099.92053, 1083.45691,   22.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 114.58480, 1105.24182, 1083.88086,   4.00000, 0.00000, 89.00000);
CreateDynamicObject(1437, 145.34930, 1102.26123, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 147.81931, 1102.26123, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 153.01930, 1102.26123, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 150.41930, 1102.26123, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 150.28931, 1113.18115, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 152.62930, 1113.18115, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 147.55930, 1113.18115, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 145.21930, 1113.18115, 1083.72876,   -8.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 145.41400, 1108.44250, 1083.73474,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 147.75400, 1108.44250, 1083.73474,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 150.35400, 1108.44250, 1083.73474,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 152.95399, 1108.44250, 1083.73474,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 152.95399, 1100.38245, 1083.73474,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 150.48399, 1100.38245, 1083.73474,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 147.88400, 1100.38245, 1083.73474,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(1437, 145.28400, 1100.38245, 1083.73474,   25.00000, 0.00000, 0.00000);
CreateDynamicObject(19362, 129.12250, 1072.53345, 1086.11414,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19362, 125.91450, 1072.53345, 1086.11414,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19362, 135.53650, 1072.53345, 1086.11414,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19362, 132.33450, 1072.53345, 1089.61584,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19362, 132.33450, 1072.53345, 1086.11511,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19362, 129.11951, 1072.53345, 1089.61584,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19362, 125.91050, 1072.53345, 1089.61584,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1537, 130.72810, 1072.64783, 1084.44360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1537, 129.23711, 1072.64783, 1084.44360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 135.54170, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 138.50169, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 141.46170, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 144.44170, 1082.80481, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 147.38170, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 150.36150, 1082.80688, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 153.30170, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 150.14880, 1080.71948, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 156.16969, 1084.43115, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.49670, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 135.54173, 1082.78406, 1090.36023,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 135.54173, 1082.78406, 1087.13623,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 135.54170, 1082.80408, 1083.70422,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 156.16969, 1087.65125, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1090.84619, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1094.04126, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1097.23621, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1100.43115, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1103.62622, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1106.82117, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1110.01624, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1113.21118, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1116.40625, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1119.60120, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1122.79614, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1125.99121, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1129.18616, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1132.38123, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 156.16969, 1135.57617, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 154.53970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 151.41969, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 148.29970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 145.17970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 142.03970, 1136.93494, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 138.93970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 135.81970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 132.69971, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 129.57970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 126.58970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 123.46970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 120.34970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 117.22970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 114.10970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 110.98970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 107.86970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 104.74970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 101.62970, 1136.93616, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 122.83370, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 119.65670, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 116.47970, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 113.30270, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 110.12570, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 106.94870, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 103.77170, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 100.59470, 1082.80408, 1093.79224,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 100.58870, 1084.48511, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1087.60815, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1090.73108, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1093.85413, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1096.97705, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1100.10010, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1103.22314, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1106.34607, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1109.46912, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1112.59204, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1115.71509, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1118.83813, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1121.96106, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1125.08411, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1128.20715, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1131.33008, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1134.45313, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 100.58870, 1137.57605, 1093.79224,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19373, 122.83370, 1082.80408, 1090.32214,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 122.83370, 1082.80408, 1086.85217,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19373, 122.83370, 1082.80408, 1083.38220,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19377, 129.10609, 1080.95105, 1097.02356,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19377, 129.10609, 1080.95105, 1107.47363,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19370, 126.57700, 1094.25244, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 129.72200, 1094.25244, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19370, 132.95200, 1094.25244, 1082.99280,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19156, 100.76840, 1083.02319, 1095.91589,   4.00000, -4.00000, -47.00000);
CreateDynamicObject(19156, 156.01331, 1082.89514, 1095.72998,   11.00000, -11.00000, 47.00000);

//squidgame room 1
CreateDynamicObject(18981, -240.33733, 2306.39795, 111.62140,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -240.35020, 2331.35010, 111.62140,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -240.32956, 2356.30981, 111.62140,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -265.28177, 2356.28491, 111.62140,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -265.27716, 2331.28760, 111.62140,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -265.33163, 2306.39282, 111.62140,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19129, -263.61694, 2296.11743, 121.97590,   -90.00000, 180.00000, 0.00000);
CreateDynamicObject(19129, -243.76151, 2296.11743, 121.97590,   -90.00000, 180.00000, 0.00000);
CreateDynamicObject(19129, -243.58884, 2355.57520, 121.97590,   -90.00000, 0.00000, 0.00000);
CreateDynamicObject(19129, -233.68881, 2306.11401, 121.97590,   -90.00000, 90.00000, 0.00000);
CreateDynamicObject(19129, -233.68770, 2325.85791, 121.97590,   -90.00000, 90.00000, 0.00000);
CreateDynamicObject(19129, -233.68800, 2345.68823, 121.97590,   -90.00000, 90.00000, 0.00000);
CreateDynamicObject(19129, -263.44400, 2355.57373, 121.97590,   -90.00000, 0.00000, 0.00000);
CreateDynamicObject(19129, -273.21680, 2306.11401, 121.97590,   -90.00000, -90.00000, 0.00000);
CreateDynamicObject(19129, -273.21680, 2325.87793, 121.97590,   -90.00000, -90.00000, 0.00000);
CreateDynamicObject(19129, -273.21680, 2345.64209, 121.97590,   -90.00000, -90.00000, 0.00000);
CreateDynamicObject(19450, -268.46210, 2296.11865, 133.71471,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -258.83609, 2296.11865, 133.71471,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -249.21609, 2296.11865, 133.71471,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -239.57610, 2296.11865, 133.71471,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -229.95610, 2296.11841, 133.71471,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -233.71719, 2301.03369, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2310.67358, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2320.27368, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2329.87378, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2339.48389, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2349.10376, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2358.72388, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -238.51970, 2355.57935, 133.71471,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -248.13969, 2355.57935, 133.71471,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -257.75970, 2355.57935, 133.71471,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -267.37970, 2355.57935, 133.71471,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -276.99969, 2355.57935, 133.71471,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -273.20511, 2350.74902, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2341.12915, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2331.50903, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2321.88916, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2312.26904, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2302.64917, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2293.02905, 133.71471,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -238.51970, 2355.57935, 137.22470,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -248.13969, 2355.57935, 137.22470,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -257.75970, 2355.57935, 137.22470,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -267.37970, 2355.57935, 137.22470,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -276.99969, 2355.57935, 137.22470,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -273.20511, 2350.74902, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2341.12915, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2331.50903, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2321.88916, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2312.26904, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2302.64917, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -273.20511, 2293.02905, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -268.46210, 2296.11865, 137.22470,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -258.83609, 2296.11865, 137.22470,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -249.21609, 2296.11865, 137.22470,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -239.57610, 2296.11865, 137.22470,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -229.95610, 2296.11841, 137.22470,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19450, -233.71719, 2301.03369, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2310.67358, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2320.27368, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2329.87378, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2339.48389, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2349.10376, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19450, -233.71719, 2358.72388, 137.22470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19430, -251.12393, 2303.35962, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(18729, -297.19534, 2355.42944, 113.23633,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1846, -252.24780, 2306.48828, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -252.24780, 2312.13623, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -252.24789, 2317.74438, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -252.26790, 2323.76514, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -252.24780, 2329.78638, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -252.24780, 2335.39429, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -252.26790, 2341.76831, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -255.43671, 2306.50781, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -255.43280, 2312.13623, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -255.43291, 2317.74438, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -255.45290, 2323.76514, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -255.43280, 2329.78638, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -255.43280, 2335.39429, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -255.45290, 2341.76831, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -255.45290, 2346.66821, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1846, -252.26790, 2346.66821, 138.61031,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1651, -255.42610, 2346.64941, 139.57919,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1651, -252.31046, 2341.74780, 139.57919,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1651, -252.33321, 2335.30542, 139.57919,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19430, -255.83990, 2349.80005, 139.66420,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -254.25990, 2349.80005, 139.66420,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -252.67590, 2349.80005, 139.66420,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -251.09190, 2349.80005, 139.66420,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -257.42389, 2349.80005, 139.66420,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(1651, -255.44547, 2329.76611, 139.57919,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1651, -252.27267, 2323.73364, 139.57919,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1651, -255.48145, 2317.71021, 139.57919,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1651, -255.42430, 2312.09546, 139.57919,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1651, -252.26141, 2306.48682, 139.57919,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18641, -233.81180, 2296.21436, 137.30949,   193.00000, 76.00000, -33.00000);
CreateDynamicObject(19430, -257.42389, 2353.28003, 139.66420,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -255.83990, 2353.28003, 139.66420,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -254.25990, 2353.28003, 139.66420,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -252.67590, 2353.28003, 139.66420,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -251.09190, 2353.28003, 139.66420,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -259.97900, 2351.04785, 139.66420,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19430, -259.97900, 2354.23975, 139.66420,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19430, -259.97900, 2352.64380, 139.66420,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19430, -248.53690, 2352.66968, 139.67120,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19430, -248.53690, 2351.10962, 139.66721,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19430, -252.72420, 2303.35889, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -254.31674, 2303.37134, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -255.90897, 2303.38403, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(3785, -260.67349, 2350.14038, 139.50670,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19281, -260.59918, 2350.06348, 139.54448,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3785, -259.24210, 2350.21045, 139.50670,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19281, -259.26944, 2350.16528, 139.60469,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3785, -249.11838, 2350.25513, 139.50670,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3785, -247.68405, 2350.26270, 139.50670,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19281, -249.06232, 2350.17773, 139.68365,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19281, -247.65582, 2350.18530, 139.47339,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19430, -257.46899, 2303.38403, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -249.56390, 2303.35962, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -249.56390, 2299.87451, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -251.15390, 2299.87451, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -252.74390, 2299.87451, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -254.33389, 2299.87451, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -255.92390, 2299.87451, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -257.51389, 2299.87451, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(1251, -251.24210, 2308.52393, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -251.24210, 2315.36084, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -251.24210, 2322.19775, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -251.24210, 2329.03491, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -251.24210, 2335.87183, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -251.24210, 2342.60278, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -251.24210, 2349.43970, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -256.43610, 2349.43970, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -256.43610, 2342.60278, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -256.43610, 2335.81860, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -256.43610, 2328.98169, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -256.43610, 2322.25073, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1251, -256.43610, 2315.41382, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19129, -243.76151, 2296.01147, 121.97590,   -90.00000, 180.00000, 0.00000);
CreateDynamicObject(1251, -256.43610, 2308.57690, 139.63330,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -268.48300, 2355.58594, 140.61560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -258.84698, 2355.58594, 140.61560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -249.25400, 2355.58594, 140.61560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -239.66100, 2355.58594, 140.61560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -230.06799, 2355.58594, 140.61560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -233.69150, 2350.74170, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.69150, 2341.10181, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.69150, 2331.46777, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.69150, 2321.90967, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.69150, 2312.28174, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.69150, 2302.67065, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.68950, 2293.03662, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -238.41310, 2296.11011, 140.61560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -248.00610, 2296.11011, 140.61560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -257.59909, 2296.11011, 140.61560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -267.19211, 2296.11011, 140.61560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -276.76511, 2296.11035, 140.61560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -273.20670, 2300.91479, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -273.20670, 2310.56079, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -273.20670, 2320.04761, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -273.20670, 2329.64063, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -273.20670, 2339.12769, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -273.20670, 2348.72070, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -273.20670, 2358.31372, 140.61560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.69150, 2350.74170, 144.11360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.69150, 2341.09961, 144.11360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -230.06799, 2355.58594, 144.11360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -239.66100, 2355.58594, 144.11360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -233.69150, 2331.45776, 144.11360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.69150, 2321.90967, 144.11360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.69150, 2312.27563, 144.11360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.69150, 2302.67065, 144.11360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -233.69350, 2293.03442, 144.11360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -238.41310, 2296.11011, 144.11360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -248.00610, 2296.11011, 144.11360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -257.59909, 2296.11011, 144.11360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -267.19211, 2296.11011, 144.11360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -276.76511, 2296.11035, 144.11360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -273.20670, 2300.91479, 144.11360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -273.20670, 2310.56079, 144.11360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -249.25400, 2355.58594, 144.11360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -258.84698, 2355.58594, 144.11360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -268.48300, 2355.60181, 144.11360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, -273.20670, 2358.31372, 144.06059,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -273.20670, 2348.72070, 144.06059,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -273.20670, 2339.12769, 144.06059,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -273.20670, 2329.64063, 144.06059,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, -273.20670, 2320.04761, 144.11360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19430, -255.92390, 2296.37646, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -257.51389, 2296.37646, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -254.33389, 2296.37646, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -252.74390, 2296.37646, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -251.15390, 2296.37646, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19430, -249.56390, 2296.37646, 139.56920,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(1504, -253.43900, 2296.17114, 139.64140,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1504, -254.93800, 2296.17114, 139.64140,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19430, -248.53690, 2354.22974, 139.67120,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19430, -248.53690, 2355.82568, 139.67320,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19430, -252.03690, 2355.82568, 139.67320,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19430, -255.53690, 2355.82568, 139.67320,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19430, -259.03690, 2355.82568, 139.66521,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19430, -259.98889, 2355.82568, 139.66920,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1504, -255.55240, 2355.48926, 139.80099,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1504, -254.05240, 2355.48926, 139.80099,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3785, -258.00687, 2348.07373, 139.50670,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3785, -250.47841, 2348.08716, 139.50670,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19281, -250.48126, 2348.00781, 139.51776,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19281, -257.96710, 2347.99414, 139.47783,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19279, -253.39690, 2296.20044, 142.48970,   -63.00000, 0.00000, 0.00000);
CreateDynamicObject(19281, -253.38524, 2296.34595, 142.55322,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19538, -255.71698, 2306.66528, 145.75240,   0.00000, 0.00000, 90.00000);

//squidgame room 2
CreateDynamicObject(19536, -337.21371, 1985.46973, 130.58270,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19436, -380.68201, 1984.03113, 132.16299,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19443, -381.18100, 1985.66638, 134.45911,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19443, -381.16101, 1982.60876, 134.45911,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19443, -381.16101, 1984.09485, 136.16310,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19443, -380.28009, 1983.33667, 134.45911,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19443, -380.28101, 1984.94482, 134.45911,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19436, -381.08969, 1986.58313, 135.21500,   0.00000, -56.00000, 90.00000);
CreateDynamicObject(19436, -381.14569, 1981.65515, 135.21500,   0.00000, 56.00000, 90.00000);
CreateDynamicObject(19443, -381.04620, 1984.10303, 136.30310,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19443, -381.87610, 1983.14075, 134.45911,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19443, -381.87610, 1984.76465, 134.45911,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19443, -380.30099, 1984.94568, 134.45911,   0.00000, -27.00000, 0.00000);
CreateDynamicObject(19443, -380.28101, 1983.34875, 134.45911,   0.00000, -27.00000, 0.00000);
CreateDynamicObject(19443, -381.87701, 1983.34875, 134.45911,   0.00000, 27.00000, 0.00000);
CreateDynamicObject(19443, -381.87701, 1984.94482, 134.45911,   0.00000, 27.00000, 0.00000);
CreateDynamicObject(1416, -381.07440, 1984.11365, 136.92320,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19143, -380.78549, 1984.36511, 137.26550,   16.00000, 4.00000, -86.00000);
CreateDynamicObject(19143, -380.78549, 1983.83313, 137.26550,   16.00000, 4.00000, -86.00000);
CreateDynamicObject(618, -386.88129, 1983.85815, 130.82390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -287.76761, 1966.56116, 118.12610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -287.76761, 1991.56116, 118.12610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -287.76761, 2016.56116, 118.12610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -375.96759, 1966.56116, 118.12610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -375.96759, 1991.56116, 118.12610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -375.96759, 2016.56116, 118.12610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -399.16760, 2004.36121, 124.32610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -399.16760, 1979.36121, 124.32610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -399.16760, 1954.36121, 124.32610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -275.36761, 2004.36121, 124.32610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -387.16760, 2015.96118, 124.32610,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, -362.16760, 2015.96118, 124.32610,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, -337.16760, 2015.96118, 124.32610,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, -312.16760, 2015.96118, 124.32610,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, -287.16760, 2015.96118, 124.32610,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, -275.36761, 1979.36121, 124.32610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -275.36761, 1954.36121, 124.32610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, -287.96759, 1954.96118, 124.32610,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, -312.76761, 1954.96118, 124.32610,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, -337.76761, 1954.96118, 124.32610,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, -362.76761, 1954.96118, 124.32610,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, -387.76761, 1954.96118, 124.32610,   0.00000, 0.00000, 90.00000);

}


public OnPlayerConnect(playerid)
{
	
	// Create TextDraw for Squid Game Timer

	squidGameDisplay = TextDrawCreate(320.0, 240.0, "00:00");
	TextDrawFont(squidGameDisplay, 2);
	TextDrawLetterSize(squidGameDisplay, 0.8, 3.5);
	TextDrawColor(squidGameDisplay, 0xFF0000FF);
	TextDrawAlignment(squidGameDisplay, 1);
	TextDrawSetShadow(squidGameDisplay, 2);
	TextDrawSetOutline(squidGameDisplay, 1);
	TextDrawBackgroundColor(squidGameDisplay, 0);

 return 1;
}

// Squid Game Timer Callback

public UpdateSquidGameTimer()
{
	if(!squidGameActive) return;
	
	if(squidGameTime > 0)
	{
		squidGameTime--;
		
		new minutes = squidGameTime / 60;
		new seconds = squidGameTime % 60;
		new timeStr[10];
		format(timeStr, sizeof(timeStr), "%02d:%02d", minutes, seconds);
		
		TextDrawSetString(squidGameDisplay, timeStr);
		
		// Change color based on time remaining
		if(squidGameTime <= 10)
		{
			TextDrawColor(squidGameDisplay, 0xFF0000FF); // Red for last 10 seconds
		}
		else if(squidGameTime <= 30)
		{
			TextDrawColor(squidGameDisplay, 0xFFFF00FF); // Yellow for last 30 seconds
		}
	}
	else
	{
		// Timer finished
		squidGameActive = 0;
		if(squidGameTimer != -1)
		{
			KillTimer(squidGameTimer);
			squidGameTimer = -1;
		}
		TextDrawHideForAll(squidGameDisplay);
	}
}

RemoveBuildings(playerid)
{


	return 1;
}
// Squid Game Start Command
CMD:startsquidgame(playerid, params[])
{
	// Check if admin or condition
	if(squidGameActive)
	{
		SendClientMessage(playerid, 0xFF0000FF, "Squid Game is already running!");
		return 1;
	}
	
	// Set game parameters (you can modify these values)
	squidGameTime = 300; // 5 minutes (300 seconds)
	squidGameActive = 1;
	
	// Show timer for all players
	TextDrawShowForAll(squidGameDisplay);
	
	// Start the timer (update every 1000ms = 1 second)
	if(squidGameTimer != -1)
	{
		KillTimer(squidGameTimer);
	}
	squidGameTimer = SetTimer("UpdateSquidGameTimer", 1000, 1);
	
	// Send message to all players
	new msg[128];
	format(msg, sizeof(msg), "Squid Game Started! Timer: %d seconds", squidGameTime);
	SendClientMessageToAll(0x00FF00FF, msg);
	
	return 1;
}

CMD:stopsquidgame(playerid, params[])
{
	if(!squidGameActive)
	{
		SendClientMessage(playerid, 0xFF0000FF, "Squid Game is not running!");
		return 1;
	}
	
	// Stop the game
	squidGameActive = 0;
	if(squidGameTimer != -1)
	{
		KillTimer(squidGameTimer);
		squidGameTimer = -1;
	}
	TextDrawHideForAll(squidGameDisplay);
	
	SendClientMessageToAll(0xFFFF00FF, "Squid Game has been stopped!");
	
	return 1;
}
