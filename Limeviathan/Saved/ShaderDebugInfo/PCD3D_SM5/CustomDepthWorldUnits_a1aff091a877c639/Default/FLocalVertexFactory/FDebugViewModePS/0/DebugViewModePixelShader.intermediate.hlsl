#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
cbuffer View
{
    float4 View_View_InvDeviceZToWorldZTransform : packoffset(c67);
};

cbuffer InstancedView
{
    row_major float4x4 InstancedView_InstancedView_SVPositionToTranslatedWorld[2] : packoffset(c88);
    row_major float4x4 InstancedView_InstancedView_ScreenToRelativeWorld[2] : packoffset(c96);
    float3 InstancedView_InstancedView_MatrixTilePosition : packoffset(c121);
    float4 InstancedView_InstancedView_ViewRectMin[2] : packoffset(c245);
    float4 InstancedView_InstancedView_ViewSizeAndInvSize : packoffset(c247);
};

cbuffer DebugViewModePass
{
    float4 DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[5] : packoffset(c7);
    float4 DebugViewModePass_DebugViewModePass_DebugViewMode_LODColors[8] : packoffset(c12);
};

cbuffer Material
{
    float4 Material_Material_PreshaderBuffer[2] : packoffset(c0);
};

float4 CPUTexelFactor;
float4 NormalizedComplexity;
int2 AnalysisParams;
float PrimitiveAlpha;
int TexCoordAnalysisIndex;
float CPULogDistance;
uint bShowQuadOverdraw;
uint bOutputQuadOverdraw;
int LODIndex;
float3 SkinCacheDebugColor;
int VisualizeMode;

RWTexture2D<uint> DebugViewModePass_QuadOverdraw;

static uint gl_PrimitiveID;
static float4 gl_FragCoord;
static float4 in_var_TEXCOORD0;
static float4 in_var_TEXCOORD1;
static float4 in_var_TEXCOORD2;
static float3 in_var_TEXCOORD3;
static float3 in_var_TEXCOORD4;
static float3 in_var_TEXCOORD5;
static uint in_var_EYE_INDEX;
static float4 out_var_SV_Target0;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD0 : TEXCOORD0;
    float4 in_var_TEXCOORD1 : TEXCOORD1;
    float4 in_var_TEXCOORD2 : TEXCOORD2;
    float3 in_var_TEXCOORD3 : TEXCOORD3;
    float3 in_var_TEXCOORD4 : TEXCOORD4;
    float3 in_var_TEXCOORD5 : TEXCOORD5;
    nointerpolation uint in_var_EYE_INDEX : EYE_INDEX;
    uint gl_PrimitiveID : SV_PrimitiveID;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
};

void frag_main()
{
    float4x4 _121 = InstancedView_InstancedView_ScreenToRelativeWorld[in_var_EYE_INDEX];
    float4 _701 = 0.0f.xxxx;
    [branch]
    if ((((VisualizeMode == 1) || (VisualizeMode == 2)) || (VisualizeMode == 3)) || (VisualizeMode == 4))
    {
        float3 _696 = 0.0f.xxx;
        if (bOutputQuadOverdraw != 0u)
        {
            float3 _610 = NormalizedComplexity.xyz;
            float3 _695 = 0.0f.xxx;
            [branch]
            if ((bShowQuadOverdraw != 0u) && (NormalizedComplexity.x > 0.0f))
            {
                uint2 _622 = uint2(gl_FragCoord.xy) / uint2(2u, 2u);
                uint _624 = 0u;
                int _627 = 0;
                _624 = 3u;
                _627 = 0;
                uint _625 = 0u;
                int _628 = 0;
                [loop]
                for (int _629 = 0; _629 < 24; _624 = _625, _627 = _628, _629++)
                {
                    uint _650 = 0u;
                    int _651 = 0;
                    [branch]
                    if (true && (_627 == 1))
                    {
                        uint4 _639 = DebugViewModePass_QuadOverdraw[_622].xxxx;
                        uint _640 = _639.x;
                        bool _643 = ((_640 >> 2u) - 1u) != uint(gl_PrimitiveID);
                        uint _648 = 0u;
                        [flatten]
                        if (_643)
                        {
                            _648 = _624;
                        }
                        else
                        {
                            _648 = _640 & 3u;
                        }
                        _650 = _648;
                        _651 = _643 ? (-1) : _627;
                    }
                    else
                    {
                        _650 = _624;
                        _651 = _627;
                    }
                    int _666 = 0;
                    [branch]
                    if (_651 == 2)
                    {
                        uint4 _656 = DebugViewModePass_QuadOverdraw[_622].xxxx;
                        uint _658 = _656.x & 3u;
                        uint _664 = 0u;
                        int _665 = 0;
                        [branch]
                        if (_658 == _650)
                        {
                            DebugViewModePass_QuadOverdraw[_622] = 0u;
                            _664 = _650;
                            _665 = -1;
                        }
                        else
                        {
                            _664 = _658;
                            _665 = _651;
                        }
                        _625 = _664;
                        _666 = _665;
                    }
                    else
                    {
                        _625 = _650;
                        _666 = _651;
                    }
                    [branch]
                    if (_666 == 0)
                    {
                        uint _673;
                        InterlockedCompareExchange(DebugViewModePass_QuadOverdraw[_622], 0u, (uint(gl_PrimitiveID) + 1u) << 2u, _673);
                        int _682 = 0;
                        [branch]
                        if (((_673 >> 2u) - 1u) == uint(gl_PrimitiveID))
                        {
                            uint _681;
                            InterlockedAdd(DebugViewModePass_QuadOverdraw[_622], 1u, _681);
                            _682 = 1;
                        }
                        else
                        {
                            _682 = (_673 == 0u) ? 2 : _666;
                        }
                        _628 = _682;
                    }
                    else
                    {
                        _628 = _666;
                    }
                }
                [branch]
                if (_627 == 2)
                {
                    DebugViewModePass_QuadOverdraw[_622] = 0u;
                }
                float3 _694 = _610;
                _694.x = NormalizedComplexity.x * (4.0f / float((_627 != (-2)) ? (1u + _624) : 0u));
                _695 = _694;
            }
            else
            {
                _695 = _610;
            }
            _696 = _695;
        }
        else
        {
            _696 = NormalizedComplexity.xyz;
        }
        _701 = float4(_696, 1.0f);
    }
    else
    {
        float4 _598 = 0.0f.xxxx;
        if (VisualizeMode == 5)
        {
            float3 _591 = 0.0f.xxx;
            if (CPULogDistance >= 0.0f)
            {
                float4 _568 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                float _577 = clamp(log2(max(1.0f, length(_568.xyz / _568.w.xxx))) - CPULogDistance, -1.9900000095367431640625f, 1.9900000095367431640625f);
                int _580 = int(floor(_577) + 2.0f);
                _591 = lerp(DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_580].xyz, DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_580 + 1].xyz, frac(_577).xxx);
            }
            else
            {
                _591 = 0.014999999664723873138427734375f.xxx;
            }
            _598 = float4(_591, PrimitiveAlpha);
        }
        else
        {
            float4 _558 = 0.0f.xxxx;
            if (VisualizeMode == 6)
            {
                float3 _551 = 0.0f.xxx;
                if (TexCoordAnalysisIndex >= 0)
                {
                    bool _471 = false;
                    float _488 = 0.0f;
                    do
                    {
                        _471 = TexCoordAnalysisIndex == 0;
                        [flatten]
                        if (_471)
                        {
                            _488 = CPUTexelFactor.x;
                            break;
                        }
                        [flatten]
                        if (TexCoordAnalysisIndex == 1)
                        {
                            _488 = CPUTexelFactor.y;
                            break;
                        }
                        [flatten]
                        if (TexCoordAnalysisIndex == 2)
                        {
                            _488 = CPUTexelFactor.z;
                            break;
                        }
                        _488 = CPUTexelFactor.w;
                        break;
                    } while(false);
                    float3 _550 = 0.0f.xxx;
                    if (_488 > 0.0f)
                    {
                        float4 _496 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                        float3 _500 = _496.xyz / _496.w.xxx;
                        float2 _515 = 0.0f.xx;
                        do
                        {
                            [flatten]
                            if (_471)
                            {
                                _515 = in_var_TEXCOORD1.xy;
                                break;
                            }
                            [flatten]
                            if (TexCoordAnalysisIndex == 1)
                            {
                                _515 = in_var_TEXCOORD1.zw;
                                break;
                            }
                            [flatten]
                            if (TexCoordAnalysisIndex == 2)
                            {
                                _515 = in_var_TEXCOORD2.xy;
                                break;
                            }
                            _515 = in_var_TEXCOORD2.zw;
                            break;
                        } while(false);
                        float2 _516 = ddx_fine(_515);
                        float2 _517 = ddy_fine(_515);
                        float _536 = clamp(log2(_488) - log2(sqrt(length(cross(ddx_fine(_500), ddy_fine(_500))) / max(abs(mad(_516.x, _517.y, -(_516.y * _517.x))), 1.0000000133514319600180897396058e-10f))), -1.9900000095367431640625f, 1.9900000095367431640625f);
                        int _539 = int(floor(_536) + 2.0f);
                        _550 = lerp(DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_539].xyz, DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_539 + 1].xyz, frac(_536).xxx);
                    }
                    else
                    {
                        _550 = 0.014999999664723873138427734375f.xxx;
                    }
                    _551 = _550;
                }
                else
                {
                    float _321 = 0.0f;
                    float _322 = 0.0f;
                    if (CPUTexelFactor.x > 0.0f)
                    {
                        float4 _292 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                        float3 _296 = _292.xyz / _292.w.xxx;
                        float2 _298 = ddx_fine(in_var_TEXCOORD1.xy);
                        float2 _299 = ddy_fine(in_var_TEXCOORD1.xy);
                        float _318 = clamp(log2(CPUTexelFactor.x) - log2(sqrt(length(cross(ddx_fine(_296), ddy_fine(_296))) / max(abs(mad(_298.x, _299.y, -(_298.y * _299.x))), 1.0000000133514319600180897396058e-10f))), -1.9900000095367431640625f, 1.9900000095367431640625f);
                        _321 = max(_318, -1024.0f);
                        _322 = min(_318, 1024.0f);
                    }
                    else
                    {
                        _321 = -1024.0f;
                        _322 = 1024.0f;
                    }
                    float _361 = 0.0f;
                    float _362 = 0.0f;
                    if (CPUTexelFactor.y > 0.0f)
                    {
                        float4 _332 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                        float3 _336 = _332.xyz / _332.w.xxx;
                        float2 _338 = ddx_fine(in_var_TEXCOORD1.zw);
                        float2 _339 = ddy_fine(in_var_TEXCOORD1.zw);
                        float _358 = clamp(log2(CPUTexelFactor.y) - log2(sqrt(length(cross(ddx_fine(_336), ddy_fine(_336))) / max(abs(mad(_338.x, _339.y, -(_338.y * _339.x))), 1.0000000133514319600180897396058e-10f))), -1.9900000095367431640625f, 1.9900000095367431640625f);
                        _361 = max(_358, _321);
                        _362 = min(_358, _322);
                    }
                    else
                    {
                        _361 = _321;
                        _362 = _322;
                    }
                    float _401 = 0.0f;
                    float _402 = 0.0f;
                    if (CPUTexelFactor.z > 0.0f)
                    {
                        float4 _372 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                        float3 _376 = _372.xyz / _372.w.xxx;
                        float2 _378 = ddx_fine(in_var_TEXCOORD2.xy);
                        float2 _379 = ddy_fine(in_var_TEXCOORD2.xy);
                        float _398 = clamp(log2(CPUTexelFactor.z) - log2(sqrt(length(cross(ddx_fine(_376), ddy_fine(_376))) / max(abs(mad(_378.x, _379.y, -(_378.y * _379.x))), 1.0000000133514319600180897396058e-10f))), -1.9900000095367431640625f, 1.9900000095367431640625f);
                        _401 = max(_398, _361);
                        _402 = min(_398, _362);
                    }
                    else
                    {
                        _401 = _361;
                        _402 = _362;
                    }
                    float _441 = 0.0f;
                    float _442 = 0.0f;
                    if (CPUTexelFactor.w > 0.0f)
                    {
                        float4 _412 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                        float3 _416 = _412.xyz / _412.w.xxx;
                        float2 _418 = ddx_fine(in_var_TEXCOORD2.zw);
                        float2 _419 = ddy_fine(in_var_TEXCOORD2.zw);
                        float _438 = clamp(log2(CPUTexelFactor.w) - log2(sqrt(length(cross(ddx_fine(_416), ddy_fine(_416))) / max(abs(mad(_418.x, _419.y, -(_418.y * _419.x))), 1.0000000133514319600180897396058e-10f))), -1.9900000095367431640625f, 1.9900000095367431640625f);
                        _441 = max(_438, _401);
                        _442 = min(_438, _402);
                    }
                    else
                    {
                        _441 = _401;
                        _442 = _402;
                    }
                    int2 _444 = int2(gl_FragCoord.xy);
                    float _450 = ((_444.x & 8) == (_444.y & 8)) ? _442 : _441;
                    float3 _468 = 0.0f.xxx;
                    if (abs(_450) != 1024.0f)
                    {
                        int _457 = int(floor(_450) + 2.0f);
                        _468 = lerp(DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_457].xyz, DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_457 + 1].xyz, frac(_450).xxx);
                    }
                    else
                    {
                        _468 = 0.014999999664723873138427734375f.xxx;
                    }
                    _551 = _468;
                }
                _558 = float4(_551, PrimitiveAlpha);
            }
            else
            {
                float4 _276 = 0.0f.xxxx;
                if ((VisualizeMode == 7) || (VisualizeMode == 8))
                {
                    float4 _275 = 0.0f.xxxx;
                    if (AnalysisParams.y != 0)
                    {
                        _275 = 256.0f.xxxx;
                    }
                    else
                    {
                        _275 = float4(0.0f, 0.0f, 0.0f, PrimitiveAlpha);
                    }
                    _276 = _275;
                }
                else
                {
                    float4 _265 = 0.0f.xxxx;
                    if ((VisualizeMode == 9) || (VisualizeMode == 10))
                    {
                        _265 = float4(0.0f, 0.0f, 0.0f, PrimitiveAlpha);
                    }
                    else
                    {
                        float4 _261 = 0.0f.xxxx;
                        if (VisualizeMode == 11)
                        {
                            float3 _236 = (InstancedView_InstancedView_MatrixTilePosition * 2097152.0f) + _121[3].xyz;
                            float4x4 _238 = _121;
                            _238[3] = float4(_236.x, _236.y, _236.z, _121[3].w);
                            _261 = float4(DebugViewModePass_DebugViewModePass_DebugViewMode_LODColors[LODIndex].xyz * mad(0.949999988079071044921875f, dot(lerp((length(-((View_View_InvDeviceZToWorldZTransform.y + ((-1.0f) / View_View_InvDeviceZToWorldZTransform.w)).xxx * mul(float4(mad((gl_FragCoord.xy - InstancedView_InstancedView_ViewRectMin[in_var_EYE_INDEX].xy) * InstancedView_InstancedView_ViewSizeAndInvSize.zw, 2.0f.xx, (-1.0f).xx), 1.0f, 0.0f), _238).xyz)) * 0.00999999977648258209228515625f).xxx, Material_Material_PreshaderBuffer[1].yzw, Material_Material_PreshaderBuffer[1].x.xxx), float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)), 0.0500000007450580596923828125f), 1.0f);
                        }
                        else
                        {
                            float4 _212 = 0.0f.xxxx;
                            if (VisualizeMode == 12)
                            {
                                float3 _187 = (InstancedView_InstancedView_MatrixTilePosition * 2097152.0f) + _121[3].xyz;
                                float4x4 _189 = _121;
                                _189[3] = float4(_187.x, _187.y, _187.z, _121[3].w);
                                _212 = float4(SkinCacheDebugColor * mad(0.949999988079071044921875f, dot(lerp((length(-((View_View_InvDeviceZToWorldZTransform.y + ((-1.0f) / View_View_InvDeviceZToWorldZTransform.w)).xxx * mul(float4(mad((gl_FragCoord.xy - InstancedView_InstancedView_ViewRectMin[in_var_EYE_INDEX].xy) * InstancedView_InstancedView_ViewSizeAndInvSize.zw, 2.0f.xx, (-1.0f).xx), 1.0f, 0.0f), _189).xyz)) * 0.00999999977648258209228515625f).xxx, Material_Material_PreshaderBuffer[1].yzw, Material_Material_PreshaderBuffer[1].x.xxx), float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)), 0.0500000007450580596923828125f), 1.0f);
                            }
                            else
                            {
                                _212 = float4(1.0f, 0.0f, 1.0f, 1.0f);
                            }
                            _261 = _212;
                        }
                        _265 = _261;
                    }
                    _276 = _265;
                }
                _558 = _276;
            }
            _598 = _558;
        }
        _701 = _598;
    }
    out_var_SV_Target0 = _701;
}

[earlydepthstencil]
SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_PrimitiveID = stage_input.gl_PrimitiveID;
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_TEXCOORD1 = stage_input.in_var_TEXCOORD1;
    in_var_TEXCOORD2 = stage_input.in_var_TEXCOORD2;
    in_var_TEXCOORD3 = stage_input.in_var_TEXCOORD3;
    in_var_TEXCOORD4 = stage_input.in_var_TEXCOORD4;
    in_var_TEXCOORD5 = stage_input.in_var_TEXCOORD5;
    in_var_EYE_INDEX = stage_input.in_var_EYE_INDEX;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    return stage_output;
}
