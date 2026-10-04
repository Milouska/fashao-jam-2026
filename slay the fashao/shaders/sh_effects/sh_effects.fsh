varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3  u_tint;
uniform float u_amount;
uniform float u_impact;

void main() {
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord);
    float lum = dot(base.rgb, vec3(0.299, 0.587, 0.114));
    vec3 tinted = mix(base.rgb, u_tint * lum * 1.5, u_amount);
    vec3 impact = vec3(1.0 - lum);
    vec3 result = mix(tinted, impact, u_impact);
    gl_FragColor = vec4(result, 1.0);
}