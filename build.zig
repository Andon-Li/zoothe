const std = @import("std");

const Translator = @import("translate_c").Translator;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    
    const translate_c = b.dependency("translate_c", .{
        .target = target,
        .optimize = optimize,
    });

    const libqt6zig = b.dependency("libqt6zig", .{
        .target = target,
        .optimize = optimize,
    });

    const miniaudio = b.dependency("miniaudio", .{
        .target = target,
        .optimize = optimize,
    });

    const miniaudio_trans: Translator = .init( translate_c, .{
        .c_source_file = miniaudio.path("miniaudio.h"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "zoothe",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .link_libcpp = true,
            .imports = &.{                
                .{
                    .name = "libqt6zig",
                    .module = libqt6zig.module("libqt6zig"),
                },
                .{
                    .name = "miniaudio",
                    .module = miniaudio_trans.mod,
                },
            }
        }),
    });
    
    exe.root_module.addCSourceFile(.{ .file = miniaudio.path("miniaudio.c")});

    // link libqt6zig libraries
    for ([_][]const u8{ 
        "qabstractbutton",
        "qapplication",
        "qpushbutton",
        "qwidget",
        "qboxlayout",
        "qlabel",
        "qslider",
        "qstylepainter",
        "qcoreevent",
        "qcolor",
        "qpainter",
        "qevent",
        "qcursor",
        "qpoint",
        "qrect",
        "qpainterpath",
        "qgraphicsitem",
        "qgraphicsscene",
        "qgraphicssceneevent",
        "qgraphicsview",
        "qguiapplication",
        "qimage",
        "qmainwindow",
        "qpixmap",
        "qstatusbar",
    }) |library| {
        exe.root_module.linkLibrary(libqt6zig.artifact(library));
    }

    // link local QT6 installations
    for ([_][]const u8{ 
        "Qt6Core", 
        "Qt6Gui", 
        "Qt6Widgets", 
        //"pthread", 
        //"dl", 
        //"X11", 
        //"xcb",
    }) |lib| {
        exe.root_module.linkSystemLibrary(lib, .{});
    }

    b.installArtifact(exe);


    // zig build run
    const run_step = b.step("run", "Run the app");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());
}
