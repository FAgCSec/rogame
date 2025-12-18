shader_type canvas_item;

uniform vec4 energy_color : source_color = vec4(0.0, 1.0, 1.0, 1.0);
uniform float energy_speed : hint_range(0.0, 10.0) = 3.0;
uniform float wave_amount : hint_range(0.0, 0.5) = 0.1;

void fragment() {
    vec2 uv = UV;
    
    // Ondas de energía
    uv.x += sin(uv.y * 10.0 + TIME * energy_speed) * wave_amount;
    uv.y += cos(uv.x * 10.0 + TIME * energy_speed) * wave_amount;
    
    vec4 color = texture(TEXTURE, uv);
    
    // Líneas de energía
    float lines = sin(uv.y * 20.0 - TIME * energy_speed * 2.0) * 0.5 + 0.5;
    lines = pow(lines, 3.0);
    
    // Mezclar con color de energía
    vec3 final_color = mix(color.rgb, energy_color.rgb, lines * 0.3);
    
    COLOR = vec4(final_color, color.a);
    COLOR.rgb += energy_color.rgb * lines * 0.2;
}
