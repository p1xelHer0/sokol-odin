// machine generated, do not edit

package sokol_imgui
import sg "../gfx"
import sapp "../app"

import "core:c"

SOKOL_DEBUG :: #config(SOKOL_DEBUG, ODIN_DEBUG)

DEBUG :: #config(SOKOL_IMGUI_DEBUG, SOKOL_DEBUG)
USE_GL :: #config(SOKOL_USE_GL, false)
USE_DLL :: #config(SOKOL_DLL, false)

when ODIN_OS == .Windows {
    when USE_DLL {
        when USE_GL {
            when DEBUG { foreign import sokol_imgui_clib { "../sokol_dll_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_imgui_clib { "../sokol_dll_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_imgui_clib { "../sokol_dll_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_imgui_clib { "../sokol_dll_windows_x64_d3d11_release.lib" } }
        }
    } else {
        when USE_GL {
            when DEBUG { foreign import sokol_imgui_clib { "sokol_imgui_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_imgui_clib { "sokol_imgui_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_imgui_clib { "sokol_imgui_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_imgui_clib { "sokol_imgui_windows_x64_d3d11_release.lib" } }
        }
    }
} else when ODIN_OS == .Darwin {
    when USE_GL {
        when ODIN_ARCH == .arm64 {
            when DEBUG { foreign import sokol_imgui_clib { "sokol_imgui_macos_arm64_gl_debug.a", "system:Cocoa.framework","system:QuartzCore.framework","system:OpenGL.framework" } }
            else       { foreign import sokol_imgui_clib { "sokol_imgui_macos_arm64_gl_release.a", "system:Cocoa.framework","system:QuartzCore.framework","system:OpenGL.framework" } }
       } else {
            when DEBUG { foreign import sokol_imgui_clib { "sokol_imgui_macos_x64_gl_debug.a", "system:Cocoa.framework","system:QuartzCore.framework","system:OpenGL.framework" } }
            else       { foreign import sokol_imgui_clib { "sokol_imgui_macos_x64_gl_release.a", "system:Cocoa.framework","system:QuartzCore.framework","system:OpenGL.framework" } }
        }
    } else {
        when ODIN_ARCH == .arm64 {
            when DEBUG { foreign import sokol_imgui_clib { "sokol_imgui_macos_arm64_metal_debug.a", "system:Cocoa.framework","system:QuartzCore.framework","system:Metal.framework","system:MetalKit.framework" } }
            else       { foreign import sokol_imgui_clib { "sokol_imgui_macos_arm64_metal_release.a", "system:Cocoa.framework","system:QuartzCore.framework","system:Metal.framework","system:MetalKit.framework" } }
        } else {
            when DEBUG { foreign import sokol_imgui_clib { "sokol_imgui_macos_x64_metal_debug.a", "system:Cocoa.framework","system:QuartzCore.framework","system:Metal.framework","system:MetalKit.framework" } }
            else       { foreign import sokol_imgui_clib { "sokol_imgui_macos_x64_metal_release.a", "system:Cocoa.framework","system:QuartzCore.framework","system:Metal.framework","system:MetalKit.framework" } }
        }
    }
} else when ODIN_OS == .Linux {
    when DEBUG { foreign import sokol_imgui_clib { "sokol_imgui_linux_x64_gl_debug.a", "system:GL", "system:dl", "system:pthread" } }
    else       { foreign import sokol_imgui_clib { "sokol_imgui_linux_x64_gl_release.a", "system:GL", "system:dl", "system:pthread" } }
} else {
    #panic("This OS is currently not supported")
}

@(default_calling_convention="c", link_prefix="simgui_")
foreign sokol_imgui_clib {
    setup :: proc(#by_ptr desc: Desc)  ---
    new_frame :: proc(#by_ptr desc: Frame_Desc)  ---
    render :: proc()  ---
    make_image :: proc(#by_ptr desc: Image_Desc) -> Image ---
    destroy_image :: proc(img: Image)  ---
    query_image_desc :: proc(img: Image) -> Image_Desc ---
    imtextureid :: proc(img: Image) -> rawptr ---
    image_from_imtextureid :: proc(imtextureid: rawptr) -> Image ---
    add_focus_event :: proc(focus: bool)  ---
    add_mouse_pos_event :: proc(x: f32, y: f32)  ---
    add_touch_pos_event :: proc(x: f32, y: f32)  ---
    add_mouse_button_event :: proc(#any_int mouse_button: c.int, down: bool)  ---
    add_mouse_wheel_event :: proc(wheel_x: f32, wheel_y: f32)  ---
    add_key_event :: proc(map_keycode: proc "c" (a0: c.int) -> c.int, #any_int keycode: c.int, down: bool)  ---
    add_input_character :: proc(c: u32)  ---
    add_input_characters_utf8 :: proc(c: cstring)  ---
    add_touch_button_event :: proc(#any_int mouse_button: c.int, down: bool)  ---
    handle_event :: proc(#by_ptr ev: sapp.Event) -> bool ---
    map_keycode :: proc(keycode: sapp.Keycode) -> c.int ---
    shutdown :: proc()  ---
    create_fonts_texture :: proc(#by_ptr desc: Font_Tex_Desc)  ---
    destroy_fonts_texture :: proc()  ---
}

INVALID_ID :: 0

Image :: struct {
    id : u32,
}

Image_Desc :: struct {
    image : sg.Image,
    sampler : sg.Sampler,
}

Log_Item :: enum i32 {
    OK,
    MALLOC_FAILED,
    IMAGE_POOL_EXHAUSTED,
}

Allocator :: struct {
    alloc_fn : proc "c" (a0: u64, a1: rawptr) -> rawptr,
    free_fn : proc "c" (a0: rawptr, a1: rawptr),
    user_data : rawptr,
}

Logger :: struct {
    func : proc "c" (a0: cstring, a1: u32, a2: u32, a3: cstring, a4: u32, a5: cstring, a6: rawptr),
    user_data : rawptr,
}

Desc :: struct {
    max_vertices : c.int,
    image_pool_size : c.int,
    color_format : sg.Pixel_Format,
    depth_format : sg.Pixel_Format,
    sample_count : c.int,
    ini_filename : cstring,
    no_default_font : bool,
    disable_paste_override : bool,
    disable_set_mouse_cursor : bool,
    disable_windows_resize_from_edges : bool,
    write_alpha_channel : bool,
    allocator : Allocator,
    logger : Logger,
}

Frame_Desc :: struct {
    width : c.int,
    height : c.int,
    delta_time : f64,
    dpi_scale : f32,
}

Font_Tex_Desc :: struct {
    min_filter : sg.Filter,
    mag_filter : sg.Filter,
}
