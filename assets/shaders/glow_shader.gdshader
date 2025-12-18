shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(0.0, 0.8, 1.0, 1.0);
uniform float glow_intensity : hint_range(0.0, 2.0) = 1.0;
uniform float pulse_speed : hint_range(0.0, 10.0) = 2.0;
uniform float glow_size : hint_range(0.0, 0.5) = 0.1;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    
    // Efecto de pulso
    float pulse = sin(TIME * pulse_speed) * 0.5 + 0.5;
    
    // Crear brillo en los bordes
    float alpha = color.a;
    vec2 center = vec2(0.5, 0.5);
    float dist = distance(UV, center);
    
    // Glow desde el centro
    float glow = smoothstep(0.5, 0.5 - glow_size, dist) * glow_intensity;
    glow *= pulse;
    
    // Mezclar color original con glow
    vec3 final_color = mix(color.rgb, glow_color.rgb, glow * 0.5);
    
    COLOR = vec4(final_color, alpha);
    COLOR.rgb += glow_color.rgb * glow * 0.3;
}
