﻿Shader "Unlit/FadeOut"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Transparency("Transparency", Range(0.0,0.99)) = 0.99
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType"="Transparent"}
        LOD 200

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha //allow transparency
		Cull Off 

        Pass
        {
		    AlphaToMask On //allow transparency

            CGPROGRAM
			
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            //#pragma multi_compile_fog

            #include "UnityCG.cginc"


            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

			float _Transparency;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);

				col.a = _Transparency; 

                return col;
            }
            ENDCG
        }
    }
}
