precision lowp float;
uniform sampler2D u_Texture;
uniform sampler2D u_Blowout; //blowout;
uniform sampler2D u_Overlay; //overlay;
uniform sampler2D u_Map; //map

varying vec2 v_TexCoordinate;

void main()
{
   	 //get the pixel
     vec3 texel = texture2D(u_Texture, v_TexCoordinate).rgb;
     vec3 bbTexel = texture2D(u_Blowout, v_TexCoordinate).rgb;

     float a;
     a = texture2D(u_Overlay, vec2(bbTexel.r, texel.r)).r;
     a = texture2D(u_Overlay, vec2(bbTexel.g, texel.g)).g;
     a = texture2D(u_Overlay, vec2(bbTexel.b, texel.b)).b;

     vec4 mapped;
     mapped.r = texture2D(u_Map, vec2(texel.r, .16666)).r;
     mapped.g = texture2D(u_Map, vec2(texel.g, .5)).g;
     mapped.b = texture2D(u_Map, vec2(texel.b, .83333)).b;
     mapped.a = 1.0;
     gl_FragColor = mapped;

}
