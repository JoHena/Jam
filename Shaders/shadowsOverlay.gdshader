shader_type canvas_item;


//uniform vec4 color : source_color = vec4(50,50,50,1);
uniform float flash_state : hint_range(0,1) = 0.5;
uniform int nb_steps : hint_range(2, 16, 1) = 2;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	
	vec4 pixelColor = textureLod(screen_texture, SCREEN_UV, 0.0);
	COLOR = pixelColor;
	
	float brightness = dot(pixelColor.rgb, vec3(0.299, 0.587, 0.114))/1.5;
	float grayStep = 1.0 / float(nb_steps - 1);
    brightness = floor(brightness / grayStep) * grayStep;
    vec4 finalColor = vec4(vec3(brightness), pixelColor.a);
	COLOR = mix(pixelColor, finalColor, flash_state);
	COLOR.a = pixelColor.a;
	
	//vec2 coords = SCREEN_PIXEL_SIZE * UV;
	//float distanceToBorder = min(min(coords.x, coords.y), min((SCREEN_PIXEL_SIZE - coords).x, (SCREEN_PIXEL_SIZE - coords).y));
	//if (distanceToBorder < SCREEN_PIXEL_SIZE.y / 4.0) {
		//COLOR = vec4(0,0,0,1);
	//}
}