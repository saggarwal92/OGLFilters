precision mediump float;
uniform sampler2D u_Texture;    //texture is the image
uniform sampler2D u_Vigenette; //vigenette;
uniform sampler2D u_Map; //map

varying vec2 v_TexCoordinate;


void main()
{
   	 //get the pixel
     vec3 texel = texture2D(u_Texture, v_TexCoordinate).rgb;
     
     texel = vec3(     texture2D(u_Map, vec2(texel.r, .16666)).r,
                       texture2D(u_Map, vec2(texel.g, .5)).g,
                       texture2D(u_Map, vec2(texel.b, .83333)).b);

     gl_FragColor = vec4(texel, 1.0);

}
