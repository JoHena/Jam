shader_type canvas_item;

uniform sampler2D noise: repeat_enable;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform vec2 scroll = vec2(0.1, 0.1);
uniform float scroll_speed = 30.0;
uniform float distortion_strength : hint_range(-1,1) = 0.2;
uniform sampler2D curve;

void fragment() {
	vec2 vecToCenter = vec2(0.35, 0.5) - UV;
	float distToCenter = length(vecToCenter);
	float curveVal = texture(curve, vec2(distToCenter)).r;
	vec2 diff = normalize(vecToCenter) * 0.6 * curveVal;
	
	
	vec4 noise_col = texture(noise, UV + scroll * TIME * scroll_speed);
	vec4 screen_col = texture(SCREEN_TEXTURE, SCREEN_UV + distortion_strength + diff * noise_col.rr);
	COLOR = screen_col;
	COLOR.rgb = screen_col.bbb;
}